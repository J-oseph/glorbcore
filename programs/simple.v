`timescale 1ps/1ps

`include "core/definitions.v"
`include "core/core.v"

module prog_Simple; 

parameter DW = 8;
parameter IW = 8;
parameter IMW = 4;

integer i,j = 0;

reg clk, start;

Core core (
    .clk(clk),
    .start(start)
);

initial begin
    $dumpfile("temp/simple.vcd");
    $dumpvars(0, prog_Simple);

    clk = 1'b0;
    start = 1'b0;
    #1 start = 1'b1;
    #4;

    #100 $display("Finished simple.txt."); $finish;
end


always begin
    #5 clk = ~clk;
end


endmodule
