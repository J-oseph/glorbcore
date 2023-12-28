
`include "core/pc.v"
`include "core/im.v"
`include "core/alu.v"

module Core (
    input wire clk,
    input wire startup
);

wire [4-1:0] pc_in, pc_out;
wire [8-1:0] instruction, r1, r2, out;

Pc pc(
    .clk(clk),
    .start(startup),
    .branch_taken(1'b0),
    .pc_in(pc_out),
    .pc_out(pc_out)
);

Im im(
    .address(pc_out),
    .instruction(instruction)
);



Alu alu(
    .instruction(instruction),
    .rs1_data(r1),
    .rd_data(r2),
    .out(out)
);

endmodule
