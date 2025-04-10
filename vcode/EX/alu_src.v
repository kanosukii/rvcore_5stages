module alu_src#(
	parameter DATA_WIDTH = 32
)
(
	input [DATA_WIDTH-1:0]alu_resm,
	input [DATA_WIDTH-1:0]result,
	input [DATA_WIDTH-1:0]rd1,
	input [DATA_WIDTH-1:0]rd2,
	input [DATA_WIDTH-1:0]pc,
	input [DATA_WIDTH-1:0]imm,
	input [1:0]rd1_ctr, // 2'b0 rd1 2'b01 alu_resm 2'b11 result
	input [1:0]rd2_ctr,
	input alu_src_1_ctr, 
	input alu_src_2_ctr,
	output [DATA_WIDTH-1:0]rd1_ture,
	output [DATA_WIDTH-1:0]rd2_ture,
	output [DATA_WIDTH-1:0]alu_src_1,
	output [DATA_WIDTH-1:0]alu_src_2
);
// rd1_ture = rd1 or alu_resm or result
// rd2_ture = rd2 or alu_resm or result
	assign rd1_ture = (rd1_ctr==2'b00) ? rd1 : ((rd1_ctr == 2'b01) ? alu_resm : result);
	assign rd2_ture = (rd2_ctr==2'b00) ? rd2 : ((rd2_ctr == 2'b01) ? alu_resm : result);
	assign alu_src_1 = alu_src_1_ctr ? pc : rd1_ture;
	assign alu_src_2 = alu_src_2_ctr ? imm : rd2_ture;
endmodule
