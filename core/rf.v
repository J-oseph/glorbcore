
module Rf #(
    parameter IW = 8,
    parameter DW = 8,
    parameter IMW = 4, 
    parameter RFW = 2 
)(
    input wire              clk,
    input wire              we,
    input wire  [RFW-1:0]   rr1_address,
    input wire  [RFW-1:0]   rr2_address,
    input wire  [RFW-1:0]   wr_address,
    input wire  [DW-1:0]    wr_data,
    output wire [DW-1:0]    rr1_data,
    output wire [DW-1:0]    rr2_data
);


reg [DW-1:0] reg_file[2**RFW-1:0];
integer i;

assign rr1_data = reg_file[rr1_address];
assign rr2_data = reg_file[rr2_address];


always @(negedge clk) begin
    if (we) begin
        reg_file[wr_address] <= wr_data;
    end
end


initial begin
    // initialize to FF for clarity
    for (i = 0; i < 2**RFW;i++) begin
        reg_file[i] <= {DW{1'b1}};
    end
    // zero register is always zero
    reg_file[{RFW{1'b0}}] <= {DW{1'b0}};
end


endmodule
