module ex#(
	parameter DATA_WITDH = 32,
	parameter ADDR_WITDH =32
)
(
	input clk, 
	input rst, 
	input reg_we,
	input [DATA_WITDH-1:0]imm,
	input jalx,
	input [3:0]branch,
	input alu_src_1_ctr,
	input alu_src_2_ctr,
	input [3:0]alu_ctr,
	input [2:0]op,
	input mem_we,
	input [4:0]rd,
	input [ADDR_WITDH-1:0]pcnd,
	input [ADDR_WITDH-1:0]pcd,
	input [DATA_WITDH-1:0]rd1,
	input [DATA_WITDH-1:0]rd2,
	input [4:0]rs1,
	input [4:0]rs2,
	input [1:0]wb_ctr,

	input [DATA_WIDTH-1:0]alu_resultm,
	input [DATA_WIDTH-1:0]result,
	input [1:0]rd1_ctr,
	input [1:0]rd2_ctr,


	output reg_wee,
	output [2:0]ope,
	output mem_wee,
	output [4:0]rde,
	output [ADDR_WITDH-1:0]pcne,
	output taken,
 	output [DATA_WITDH-1:0]alu_result,
	output [DATA_WITDH-1:0]rd2_ture,
	output [1:0]wb_ctre
	output [4:0]rs1e,
	output [4:0]rs2e

);
	wire [DATA_WITDH-1:0]imme,pce,rd1e,rd2e;
	wire jalxe,alu_src_1_ctre,alu_src_2_ctre;
	wire [3:0]branche,alu_ctre;

	ex_dff(
	.clk(clk),
	.rst(rst),
	.reg_we(reg_we),
	.imm(imm),
	.jalx(jalx),
	.branch(branch),
	.alu_src_1_ctr(alu_src_1_ctr),
	.alu_src_2_ctr(alu_src_2_ctr),
	.alu_ctr(alu_ctr),
	.op(op),
	.mem_we(mem_we),
	.rd(rd),
	.pcnd(pcnd),
	.pcd(pcd),
	.rd1(rd1),
	.rd2(rd2),
	.rs1(rs1),
	.rs2(rs2),	
	.wb_ctr(wb_ctr),

	.reg_wee(reg_wee),
	.imme(imme),
	.jalxe(jalxe),
	.branche(branche),
	.alu_src_1_ctre(alu_src_1_ctre),
	.alu_src_2_ctre(alu_src_2_ctre),
	.alu_ctre(alu_ctre),
	.ope(ope),
	.mem_wee(mem_wee),
	.rde(rde),
	.pcne(pcne),
	.pce(pce),
	.rd1e(rd1e),
	.rd2e(rd2e),
	.rs1e(rs1e),
	.rs2e(rs2e),
	.wb_ctre(wb_ctre)
);

	wire [DATA_WITDH-1:0]rd1_ture,rd2_ture,alu_src_1,alu_src_2;
	alu_src u_alu_src(
	.alu_resm(alu_resm),
	.result(result),
	.rd1(rd1e),
	.rd2(rd2e),
	.pc(pce),
	.imm(imme),
	.rd1_ctr(rd1_ctr),
	.rd2_ctr(rd2_ctr),
	.alu_src_1_ctr(alu_src_1e_ctr),
	.alu_src_2_ctr(alu_src_2e_ctr),
	.rd1_ture(rd1_ture),
	.rd2_ture(rd2_ture),
	.alu_src_1(alu_src_1),
	.alu_src_2(alu_src_2)	
);

	alu u_alu(
	.ctr(alu_ctre),
	.a(alu_src_1),
	.b(alu_src_2),
	.result(alu_result),
	.less(),
	.zero()
);

	branch u_branch(
	.branch(branche),
	.jalx(jalxe),
	.rd1(rd1_ture),
	.rd2(rd2_ture),
	.taken(taken)	
);	
endmodule
