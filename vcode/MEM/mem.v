module mem#(
	parameter DATA_WIDTH = 32,
	parameter ADDR_WIDTH = 32
)
(
	input clk,
	input rst,
	input reg_wee,
	input [2:0]ope,
	input mem_wee,
	input [4:0]rde,
	input [ADDR_WIDTH-1:0]pcne,
 	input [DATA_WIDTH-1:0]alu_result,
	input [DATA_WIDTH-1:0]rd2_ture,
	input [1:0]wb_ctre,
	input [DATA_WIDTH-1:0]data_in,

	output reg_wem,
	output [4:0]rdm,
	output [ADDR_WIDTH-1:0]pcnm,
 	output [DATA_WIDTH-1:0]alu_resultm,
	output [1:0]wb_ctrm,

	output [3:0]wmask,
	output mem_wem,
	output [DATA_WIDTH-1:0]rd2_turem,
	output [DATA_WIDTH-1:0]data_out
);
	wire [2:0]opm;


	mem_dff u_mem_dff(
	.clk(clk),
	.rst(rst),	
	.reg_wee(reg_wee),
	.ope(ope),
	.mem_wee(mem_wee),
	.rde(rde),
	.pcne(pcne),
	.alu_result(alu_result),
	.rd2_ture(rd2_ture),
	.wb_ctre(wb_ctre),

	.reg_wem(reg_wem),
	.opm(opm),
	.mem_wem(mem_wem),
	.rdm(rdm),
	.pcnm(pcnm),
	.alu_resultm(alu_resultm),	
	.rd2_turem(rd2_turem),
	.wb_ctrm(wb_ctrm)
);

	data_mem_ctr u_data_mem_ctr(
	.op(opm),
	.data_in(data_in),
	.wmask(wmask),
	.data_out(data_out)	
);
endmodule
