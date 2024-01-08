
`include "core/definitions.v"

module Alu #(
    parameter IW = 12,
    parameter IMW = 4,
    parameter DW = 12 
)(
    input wire [IW-1:0] instruction,
    input wire [DW-1:0] rs1_data,
    input wire [DW-1:0] rs2_data,
    input wire [IMW-1:0] pc,
    output reg [DW-1:0] out
);

wire [1:0]  op      = instruction[1:0];
wire [5:0]  imm     = instruction[11:6];

wire [3:0]  r_funct = instruction[11:8];
wire [1:0]  r_rs2   = instruction[7:6];
wire [1:0]  r_rs1   = instruction[5:4];
wire [1:0]  r_rd    = instruction[3:2];

wire [1:0]  i_rs1   = instruction[5:4];
wire [1:0]  i_rd    = instruction[3:2];

wire [1:0]  b_rs1   = instruction[5:4];
wire [1:0]  b_funct = instruction[3:2];


always @(*) begin
    case (op)
        `OP_R:
            begin
                case (r_funct)
                    `R_ADD:     out = rs1_data + rs2_data;
                    `R_AND:     out = rs1_data & rs2_data;
                    `R_OR:      out = rs1_data | rs2_data;
                    `R_XOR:     out = rs1_data ^ rs2_data;
                    default:    out = {DW{1'bX}}; 
                endcase
            end
        `OP_I:
            begin
                out = rs1_data + imm;
            end
        `OP_B:
            begin
                case (b_funct)
                    //`B_BEQ:     out = rs1_data == rs2_data ? b_imm: 1;
                    `B_BEQ:     out = imm;
                    `B_BLT:     out = rs1_data < rs2_data ? imm: pc;
                    default:    out = {DW{1'bX}}; 
                endcase
            end
        default:    out = {DW{1'bX}}; 
    endcase
end

endmodule
