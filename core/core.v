
`include "core/pc.v"
`include "core/im.v"
`include "core/id.v"
`include "core/rf.v"
`include "core/alu.v"


module Core #(
    parameter filename = "programs/simple.txt",
    parameter IW = 8,
    parameter IMW = 4,
    parameter DW = 8,
    parameter RFW = 2
)(
    input wire clk,
    input wire start
);

wire rf_we, branch_taken;
wire [IMW-1:0] pc_in, pc_out;
wire [IW-1:0] instruction;
wire [DW-1:0] wr_data, rs1_data, rd_data;
wire [RFW-1:0] rs1_address, rd_address;

Pc # (
    .IW(IW),
    .IMW(IMW)
) pc(
    .clk(clk),
    .start(start),
    .branch_taken(branch_taken),
    .pc_in(wr_data[IMW-1:0]),
    .pc_out(pc_out)
);

Im #(
    .filename(filename),
    .IW(IW),
    .IMW(IMW)
) im(
    .address(pc_out),
    .instruction(instruction)
);

Id #(
    .IW(IW),
    .IMW(IMW),
    .RFW(RFW)
) id(
    .instruction(instruction),
    .rf_we(rf_we),
    .branch_taken(branch_taken),
    .rs1_address(rs1_address),
    .rd_address(rd_address)
);

Rf #(
    .IW(IW),
    .IMW(IMW),
    .DW(DW),
    .RFW(RFW)
) rf(
    .clk(clk),
    .we(rf_we),
    .rr1_address(rs1_address),
    .rr2_address(rd_address),
    .wr_address(rd_address),
    .wr_data(wr_data),
    .rr1_data(rs1_data),
    .rr2_data(rd_data)
);

Alu #(
    .IW(IW),
    .IMW(IMW),
    .DW(DW)
) alu(
    .instruction(instruction),
    .rs1_data(rs1_data),
    .rd_data(rd_data),
    .pc(pc_out),
    .out(wr_data)
);


endmodule
