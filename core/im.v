
module Im #(
    parameter IW = 8,
    parameter IMW = 4,
    parameter filename = "programs/simple.txt"
)(
    input wire [IMW-1:0] address,
    output wire [IW-1:0] instruction
);


reg [IW-1:0] mem[0:2**IMW-1];

assign instruction = mem[address];


initial begin
    $readmemb(filename, mem);
end


endmodule
