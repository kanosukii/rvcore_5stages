module data_mem#(
	parameter ADDR_WIDTH = 15,
	parameter DATA_WIDTH = 32
)
(
	input clk,
	input [ADDR_WIDTH-1:0]addr,
	input [DATA_WIDTH-1:0]data_in,
	input [3:0]wmask,
	input we,
	output [DATA_WIDTH-1:0]data_out
);
	reg [DATA_WIDTH-1:0]mem[0:(1 << ADDR_WIDTH)-1];
//read
	assign data_out = mem[addr];	
//write wmask
	always @(posedge clk) begin
	if(we)begin
		if(wmask[0]) mem[addr][7:0] <= data_in[7:0];
		if(wmask[1]) mem[addr][15:8] <= data_in[15:8];
		if(wmask[2]) mem[addr][23:16] <= data_in[23:16];
		if(wmask[3]) mem[addr][31:24] <= data_in[31:24];
	end
end
endmodule
