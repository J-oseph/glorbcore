
`include "core/definitions.v"

module Id #(
    parameter IW = 8,
    parameter IMW = 4,
    parameter RFW = 2 
)(
    input wire [IW-1:0] instruction,
    output wire           rf_we,
    output wire           branch_taken,
    output wire [RFW-1:0] rs1_address,
    output wire [RFW-1:0] rd_address
);


wire        op      = instruction[0];

assign rs1_address = instruction[7:6];
assign rd_address = instruction[5:4];
assign rf_we = (op == `OP_R) && (rd_address != `REG0);
assign branch_taken = (op == `OP_B); // FIXME: branches are just always taken if branch instruction

endmodule
