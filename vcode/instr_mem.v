module instr_mem#(
	parameter ADDR_WIDTH = 16,
	parameter DATA_WIDTH = 32
)
(
	input [ADDR_WIDTH-1:0]addr,
	output [DATA_WIDTH-1:0]data
);
	reg [DATA_WIDTH-1:0]mem[0:(1 << ADDR_WIDTH) -1];
	assign data = mem[addr];
endmodule
