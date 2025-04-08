module data_mem_unit#(
	parameter ADDR_WIDTH = 15,
	parameter DATA_WIDTH = 32
)
(
	input clk,
	input [2:0]op,
	input [ADDR_WIDTH-1:0]addr,
	input [DATA_WIDTH-1:0]data_in,
	input we,
	output [DATA_WIDTH-1:0]data_out
);

	wire [3:0]wmask;
	wire [DATA_WIDTH-1:0]data_temp;
	data_mem_ctr u_data_mem_ctr(
	.op(op),
	.data_in(data_temp),
	.wmask(wmask),
	.data_out(data_out)
);

	data_mem u_data_mem(
	.clk(clk),
	.addr(addr),
	.data_in(data_in),
	.wmask(wmask),
	.we(we),
	.data_out(data_temp)
);
endmodule
