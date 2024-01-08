
module Pc #(
    parameter IW = 12,
    parameter IMW = 4 
)(
    input wire clk,
    input wire start,
    input wire branch_taken,
    input wire [IMW-1:0] pc_in,
    output reg [IMW-1:0] pc_out
);

wire [IMW-1:0] next_pc = pc_out + 1;

wire [IMW-1:0] pc_out_w = branch_taken ? pc_in: next_pc;

always @(posedge clk) begin
    pc_out <= pc_out_w;
end

always @(posedge start) begin
    pc_out <= {IMW{1'b0}};
end

endmodule
