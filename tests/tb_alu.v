`timescale 1ps/1ps

`include "core/definitions.v"
`include "core/alu.v"

module tb_Alu; 

parameter DW = 8;
parameter IW = 8;

integer i,j = 0;

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

            rs1_data = 8'h00; rd_data = 8'h00; expected_out = 8'h00;
            #1; checkOutput;
            rs1_data = 8'hFF; rd_data = 8'h01; expected_out = 8'h00;
            #1; checkOutput;
            rs1_data = 8'h01; rd_data = 8'hFF; expected_out = 8'h00;
            #1; checkOutput;
            rs1_data = 8'hFF; rd_data = 8'hFF; expected_out = 8'hFE;
            #1; checkOutput;
            rs1_data = 8'h11; rd_data = 8'h22; expected_out = 8'h33;
            #1; checkOutput;
        end
    end
endtask


task automatic testAND;
    for (i=0; i<2; i++) begin
        for (j=0; j<2; j++) begin
            instruction = {i[0], j[0], `R_AND, 1'b0, `OP_R};

            rs1_data = 8'h00; rd_data = 8'h00; expected_out = 8'h00;
            #1; checkOutput;
            rs1_data = 8'hFF; rd_data = 8'h00; expected_out = 8'h00;
            #1; checkOutput;
            rs1_data = 8'h00; rd_data = 8'hFF; expected_out = 8'h00;
            #1; checkOutput;
            rs1_data = 8'hFF; rd_data = 8'hAA; expected_out = 8'hAA;
            #1; checkOutput;
            rs1_data = 8'hA8; rd_data = 8'h89; expected_out = 8'h88;
            #1; checkOutput;
        end
    end
endtask


task automatic testOR;
    for (i=0; i<2; i++) begin
        for (j=0; j<2; j++) begin
            instruction = {i[0], j[0], `R_OR, 1'b0, `OP_R};

            rs1_data = 8'h00; rd_data = 8'h00; expected_out = 8'h00;
            #1; checkOutput;
            rs1_data = 8'hFF; rd_data = 8'h00; expected_out = 8'hFF;
            #1; checkOutput;
            rs1_data = 8'h00; rd_data = 8'hFF; expected_out = 8'hFF;
            #1; checkOutput;
            rs1_data = 8'hFF; rd_data = 8'hAA; expected_out = 8'hFF;
            #1; checkOutput;
            rs1_data = 8'hA8; rd_data = 8'h89; expected_out = 8'hA9;
            #1; checkOutput;
        end
    end
endtask


task automatic testXOR;
    for (i=0; i<1; i++) begin
        for (j=0; j<1; j++) begin
            instruction = {i[0], j[0], `R_XOR, 1'b0, `OP_R};

            rs1_data = 8'h00; rd_data = 8'h00; expected_out = 8'h00;
            #1; checkOutput;
            rs1_data = 8'hFF; rd_data = 8'hFF; expected_out = 8'h00;
            #1; checkOutput;
            rs1_data = 8'hFF; rd_data = 8'h00; expected_out = 8'hFF;
            #1; checkOutput;
            rs1_data = 8'hFF; rd_data = 8'hAA; expected_out = 8'h55;
            #1; checkOutput;
            rs1_data = 8'hA8; rd_data = 8'h89; expected_out = 8'h21;
            #1; checkOutput;
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
    end
endtask


endmodule
