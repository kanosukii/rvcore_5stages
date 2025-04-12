module de#(
	parameter DATA_WIDTH = 32,
	parameter ADDR_WIDTH =32
)
(
	input clk,
	input rst,
	input en,
	input [ADDR_WIDTH-1:0]instr,
	input [ADDR_WIDTH-1:0]pc,
	input [ADDR_WIDTH-1:0]pcn,
	input [4:0]rdw,
	input wew,
	input [DATA_WIDTH-1:0]wdw,

	output [4:0]rs1,
	output [4:0]rs2,
	output [4:0]rd,
	output [3:0]branch,
	output [DATA_WIDTH-1:0]imm,
	output alu_src_1_ctr,// 1'b0 rs1 1'b1 pc
	output alu_src_2_ctr,// 1'b0 rs2 1'b1 imm 
	output [3:0]alu_ctr,
	output jalx,
	output [2:0]op,
	output reg_we,
	output mem_we,
	output [ADDR_WIDTH-1:0]pcnd,
	output [ADDR_WIDTH-1:0]pcd,
	output [DATA_WIDTH-1:0]rd1,
	output [DATA_WIDTH-1:0]rd2,
	output [1:0]wb_ctr,
	output rs1_need,
	output rs2_need
);
	wire [ADDR_WIDTH-1:0]instrd;

	decode u_decode(
	.instr(instrd),
	.rs1(rs1),
	.rs2(rs2),
	.rd(rd),
	.branch(branch),
	.imm(imm),
	.alu_src_a(alu_src_1_ctr),
	.alu_src_b(alu_src_2_ctr),
	.alu_ctr(alu_ctr),
	.jalx(jalx),
	.op(op),
	.reg_we(reg_we),
	.mem_we(mem_we),
	.wb_ctr(wb_ctr),
	.rs1_need(rs1_need),
	.rs2_need(rs2_need)
);

	de_dff u_de_dff(
	.clk(clk),
	.rst(rst),
	.en(en),
	.pcn(pcn),
	.pc(pc),
	.instr(instr),
	.pcnd(pcnd),
	.pcd(pcd),
	.instrd(instrd)
);

	register u_register(
	.clk(clk),
	.rs1(rs1),
	.rs2(rs2),
	.rd(rdw),
	.we(wew),
	.wd(wdw),
	.rd1(rd1),
	.rd2(rd2)
);

endmodule
