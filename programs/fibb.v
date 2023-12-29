`timescale 1ps/1ps

`include "core/definitions.v"
`include "core/core.v"

module prog_Fibb; 

parameter DW = 8;
parameter IW = 8;
parameter IMW = 4;

integer i,j = 0;

reg clk, start;

Core #(
    .filename("programs/fibb.txt")
) core(
    .clk(clk),
    .start(start)
);

initial begin
    $dumpfile("temp/fibb.vcd");
    $dumpvars(0, prog_Fibb);

    clk = 1'b0;
    start = 1'b0;
    #1 start = 1'b1;
    #4;

    #1000 $display("Finished fibb.txt."); $finish;
end


always begin
    #5 clk = ~clk;
end


endmodule
