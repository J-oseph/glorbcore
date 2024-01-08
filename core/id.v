
`include "core/definitions.v"

module Id #(
    parameter IW = 12,
    parameter IMW = 4,
    parameter RFW = 2 
)(
    input wire [IW-1:0] instruction,
    output wire           rf_we,
    output wire           branch_taken,
    output wire [RFW-1:0] rs1_address,
    output wire [RFW-1:0] rs2_address,
    output reg  [RFW-1:0] rd_address
);


wire [1:0]  op      = instruction[1:0];

assign rs1_address = instruction[5:4];
assign rs2_address = instruction[7:6];
assign rf_we = (op == `OP_R || op == `OP_I) && (rd_address != `REG0);
assign branch_taken = (op == `OP_B); // FIXME: branches are just always taken if branch instruction

always @(*) begin
    if (op == `OP_I || op == `OP_R) begin
        rd_address = instruction[3:2];
    end else begin
        rd_address = {RFW{1'bX}};
    end
end

endmodule
