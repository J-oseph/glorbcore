
`include "core/definitions.v"

module Alu #(
    parameter IW = 8,
    parameter IMW = 4,
    parameter DW = 8
)(
    input wire [IW-1:0] instruction,
    input wire [DW-1:0] rs1_data,
    input wire [DW-1:0] rd_data,
    input wire [IMW-1:0] pc,
    output reg [DW-1:0] out
);
wire        op      = instruction[0];

wire [1:0]  r_rs1   = instruction[7:6];
wire [1:0]  r_rd    = instruction[5:4];
wire [1:0]  r_funct = instruction[3:2];

wire [4:0]  b_imm   = instruction[7:2];
wire        b_funct = instruction[1];

always @(*) begin
    case (op)
        `OP_R:
            begin
                case (r_funct)
                    `R_ADD:     out = rs1_data + rd_data;
                    `R_AND:     out = rs1_data & rd_data;
                    `R_OR:      out = rs1_data | rd_data;
                    `R_XOR:     out = rs1_data ^ rd_data;
                    default:    out = 8'bX; 
                endcase
            end
        `OP_B:
            begin
                case (b_funct)
                    //`B_BEQ:     out = rs1_data == rd_data ? b_imm: 1;
                    `B_BEQ:     out = pc + b_imm;
                    `B_BLT:     out = rs1_data < rd_data ? b_imm: 1;
                    default:    out = 8'bX;
                endcase
            end
        default:    out = 8'bX;
    endcase
end

endmodule
