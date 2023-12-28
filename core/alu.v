
`define OP_R    1'b0
`define OP_B    1'b1

`define R_ADD   2'b00
`define R_AND   2'b01
`define R_OR    2'b10
`define R_XOR   2'b11

`define B_BEQ   1'b0
`define B_BLT   1'b1


module Alu #(
    parameter DW = 8,
    parameter IW = 8
)(
    input wire [IW-1:0] instruction,
    input wire [DW-1:0] rs1_data,
    input wire [DW-1:0] rd_data,
    output reg [DW-1:0] out
);

assign op       = instruction[0];

assign r_rs1    = instruction[7:6];
assign r_rd     = instruction[5:4];
assign r_funct  = instruction[3:2];

assign b_imm    = instruction[7:2];
assign b_funct  = instruction[1];

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
        `OP_R:
            begin
                case (b_funct)
                    `B_BEQ:     out = rs1_data == rd_data ? b_imm: 1;
                    `B_BLT:     out = rs1_data < rd_data ? b_imm: 1;
                    default:    out = 8'bX;
                endcase
            end
        default:    out = 8'bX;
    endcase
end

endmodule
