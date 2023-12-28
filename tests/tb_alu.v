
`include "core/alu.v"

module tb_Alu; 

parameter DW = 8;
parameter IW = 8;

reg [IW-1:0] instruction;
reg [DW-1:0] r1, r2;
wire [DW-1:0] out;

Alu #(.DW(DW),.IW(IW))
alu(
    .instruction(instruction),
    .rs1_data(r1),
    .rd_data(r2),
    .out(out)
);

initial begin
    $dumpfile("temp/ALU.vcd");
    $dumpvars(0, tb_Alu);

    instruction = 8'b01_00_00_00;
    r1 = 1;
    r2 = 2;
    #10 $display("\n\nFinished tb_alu.");
    $finish;
end



endmodule
