`timescale 1ps/1ps

`include "core/definitions.v"
`include "core/pc.v"

module tb_Pc; 

parameter DW = 8;
parameter IW = 8;
parameter IMW = 4;

integer i,j = 0;

reg clk, start, branch_taken;
reg [IMW-1:0] pc_in;
wire [IMW-1:0] pc_out;

wire [IMW-1:0] expected_out = i[IMW-1:0] + 1;

Pc pc (
    .clk(clk),
    .start(start),
    .branch_taken(branch_taken),
    .pc_in(pc_in),
    .pc_out(pc_out)
);


initial begin
    $dumpfile("temp/tb_pc.vcd");
    $dumpvars(0, tb_Pc);

    branch_taken = 1'b0; 
    pc_in = {IMW-1{1'b1}};
    clk = 1'b0;
    start = 1'b0;
    #1 start = 1'b1;
    #4;

    for (i = 0; i < 100; i++) begin
        if (pc_out != expected_out) begin
            $display(
                "FAILED AT TIME %0ps. pc_out=0x%h (expected 0x%h)",
                $time,
                pc_out,
                expected_out
            );
        end
        #10;
    end

    #10 $display("Finished tb_pc."); $finish;
end


always begin
    #5 clk = ~clk;
end


endmodule
