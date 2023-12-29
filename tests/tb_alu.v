`timescale 1ps/1ps

`include "core/definitions.v"
`include "core/alu.v"

module tb_Alu; 

parameter DW = 8;
parameter IW = 8;

integer i,j,a,b,c = 0;

reg [IW-1:0] instruction;
reg signed [DW-1:0] rs1_data, rd_data, expected_out;
wire signed [DW-1:0] out;

Alu #(.DW(DW),.IW(IW))
alu(
    .instruction(instruction),
    .rs1_data(rs1_data),
    .rd_data(rd_data),
    .out(out)
);


initial begin
    $dumpfile("temp/tb_alu.vcd");
    $dumpvars(0, tb_Alu);

    testADD;
    testAND;
    testOR;
    testXOR;

    $display("Finished tb_alu."); $finish;
end


task automatic testADD;
    for (i=0; i<2; i++) begin
        for (j=0; j<2; j++) begin
            instruction = {i[0], j[0], `R_ADD, 1'b0, `OP_R};
            for (a=0;a<2**DW;a++) begin
                for (b=0;b<2**DW;b++) begin
                   rs1_data = a[DW-1:0]; 
                   rd_data = b[DW-1:0]; 
                   expected_out = a + b;
                   #1; checkOutput;
                end
            end
        end
    end
endtask


task automatic testAND;
    for (i=0; i<2; i++) begin
        for (j=0; j<2; j++) begin
            instruction = {i[0], j[0], `R_AND, 1'b0, `OP_R};
            for (a=0;a<2**DW;a++) begin
                for (b=0;b<2**DW;b++) begin
                   rs1_data = a[DW-1:0]; 
                   rd_data = b[DW-1:0]; 
                   expected_out = a & b;
                   #1; checkOutput;
                end
            end
        end
    end
endtask


task automatic testOR;
    for (i=0; i<2; i++) begin
        for (j=0; j<2; j++) begin
            instruction = {i[0], j[0], `R_OR, 1'b0, `OP_R};
            for (a=0;a<2**DW;a++) begin
                for (b=0;b<2**DW;b++) begin
                   rs1_data = a[DW-1:0]; 
                   rd_data = b[DW-1:0]; 
                   expected_out = a | b;
                   #1; checkOutput;
                end
            end
        end
    end
endtask


task automatic testXOR;
    for (i=0; i<2; i++) begin
        for (j=0; j<2; j++) begin
            instruction = {i[0], j[0], `R_XOR, 1'b0, `OP_R};
            for (a=0;a<2**DW;a++) begin
                for (b=0;b<2**DW;b++) begin
                   rs1_data = a[DW-1:0]; 
                   rd_data = b[DW-1:0]; 
                   expected_out = a ^ b;
                   #1; checkOutput;
                end
            end
        end
    end
endtask


task automatic checkOutput;
    if (out !== expected_out) begin
        $display(
            "FAILED AT TIME %0tps. %h [%d]   %h [%d] = %h [%d] (expected %h [%d])",
            $time,
            rs1_data, rs1_data,
            rd_data, rd_data,
            out, out,
            expected_out, expected_out
        );
        $finish;
    end
endtask


endmodule
