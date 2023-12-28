
`include "core/alu.v"

module Core (
    input wire clk,
    input wire startup
);

wire [8-1:0] instruction, r1, r2, out;

Alu alu(
    .instruction(instruction),
    .rs1_data(r1),
    .rd_data(r2),
    .out(out)
);

endmodule
