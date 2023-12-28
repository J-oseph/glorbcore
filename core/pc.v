
module Pc #(
    parameter IW = 8,
    parameter IMW = 4 
)(
    input wire clk,
    input wire start,
    input wire branch_taken,
    input wire [IMW-1:0] pc_in,
    output wire [IMW-1:0] pc_out
);

reg [IMW-1:0] next_pc;

assign pc_out = branch_taken ? pc_in: next_pc;

always @(posedge clk) begin
    next_pc = pc_out + 1;
end

always @(posedge start) begin
    next_pc = {IMW{1'b0}};
end

endmodule
