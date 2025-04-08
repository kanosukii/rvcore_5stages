module decode#(
	parameter DATA_WIDTH = 32
)(
	input [DATA_WIDTH-1:0]instr,
	output [4:0]rs1,
	output [4:0]rs2,
	output [4:0]rd,
	output [3:0]branch,
	output [DATA_WIDTH-1:0]imm,
	output alu_src_a,
	output alu_src_b,
	output [2:0]op,
	output reg_we,
	output mem_we,
	output [3:0]alu_ctr,
	output jalx
);


endmodule
