`timescale 1ps/1ps

`include "core/definitions.v"
`include "core/alu.v"

module tb_Alu; 

parameter DW = 8;
parameter IW = 8;

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

    // ADD
    instruction = {`REG1, `REG0, `R_ADD, 1'b0, `OP_R};
    rs1_data = 8'h00; rd_data = 8'h00; expected_out = 8'h00;
    #10; checkOutput;
    rs1_data = 8'hFF; rd_data = 8'h01; expected_out = 8'h00;
    #10; checkOutput;
    rs1_data = 8'h01; rd_data = 8'hFF; expected_out = 8'h00;
    #10; checkOutput;
    rs1_data = 8'hFF; rd_data = 8'hFF; expected_out = 8'hFE;
    #10; checkOutput;
    rs1_data = 8'h11; rd_data = 8'h22; expected_out = 8'h33;
    #10; checkOutput;

    // AND
    instruction = {`REG1, `REG0, `R_AND, 1'b0, `OP_R};
    rs1_data = 8'h00; rd_data = 8'h00; expected_out = 8'h00;
    #10; checkOutput;
    rs1_data = 8'hFF; rd_data = 8'h00; expected_out = 8'h00;
    #10; checkOutput;
    rs1_data = 8'h00; rd_data = 8'hFF; expected_out = 8'h00;
    #10; checkOutput;
    rs1_data = 8'hFF; rd_data = 8'hAA; expected_out = 8'hAA;
    #10; checkOutput;
    rs1_data = 8'hA8; rd_data = 8'h89; expected_out = 8'h88;
    #10; checkOutput;

    // OR
    instruction = {`REG1, `REG0, `R_XOR, 1'b0, `OP_R};
    rs1_data = 8'h00; rd_data = 8'h00; expected_out = 8'h00;
    #10; checkOutput;
    rs1_data = 8'hFF; rd_data = 8'h00; expected_out = 8'hFF;
    #10; checkOutput;
    rs1_data = 8'h00; rd_data = 8'hFF; expected_out = 8'hFF;
    #10; checkOutput;
    rs1_data = 8'hFF; rd_data = 8'hAA; expected_out = 8'hFF;
    #10; checkOutput;
    rs1_data = 8'hA8; rd_data = 8'h89; expected_out = 8'hA9;
    #10; checkOutput;

    $display("Finished tb_alu."); $finish;
end


task checkOutput;
    if (out !== expected_out) begin
        $display(
            "FAILED AT TIME %0tps. %h [%d]   %h [%d] = %h [%d] (expected %h [%d])",
            $time,
            rs1_data, rs1_data,
            rd_data, rd_data,
            out, out,
            expected_out, expected_out
        );
        //$finish;
    end
endtask


endmodule
