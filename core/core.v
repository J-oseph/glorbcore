
`include "core/pc.v"
`include "core/im.v"
`include "core/id.v"
`include "core/rf.v"
`include "core/alu.v"


module Core (
    input wire clk,
    input wire start
);

wire rf_we, branch_taken;
wire [4-1:0] pc_in, pc_out;
wire [8-1:0] instruction, wr_data, rs1_data, rd_data;
wire [2-1:0] rs1_address, rd_address;

Pc pc(
    .clk(clk),
    .start(start),
    .branch_taken(branch_taken),
    .pc_in(rd_data[4-1:0]),
    .pc_out(pc_out)
);

Im im(
    .address(pc_out),
    .instruction(instruction)
);

Id id(
    .instruction(instruction),
    .rf_we(rf_we),
    .branch_taken(branch_taken),
    .rs1_address(rs1_address),
    .rd_address(rd_address)
);

Rf rf(
    .clk(clk),
    .we(rf_we),
    .rr1_address(rs1_address),
    .rr2_address(rd_address),
    .wr_address(rd_address),
    .wr_data(wr_data),
    .rr1_data(rs1_data),
    .rr2_data(rd_data)
);

Alu alu(
    .instruction(instruction),
    .rs1_data(rs1_data),
    .rd_data(rd_data),
    .pc(pc_out),
    .out(wr_data)
);


endmodule
