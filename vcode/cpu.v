module cpu#(
	parameter ADDR_WITDH = 32,
	parameter DATA_WITDH = 32
)(
	input clk,
	input rst,
	input [ADDR_WITDH-1:0]instr,
	input [DATA_WITDH-1:0]data,

	output [DATA_WITDH-1:0]alu_resultm,
	output [DATA_WITDH-1:0]rd2_turem,
	output [3:0]wmask,
	output mem_wem,
	output [ADDR_WITDH-1:0]pc
	

);
	wire if_en,taken,
	wire [DATA_WITDH-1:0]alu_result,

	wire [ADDR_WITDH-1:0]pcn,

	pc u_pc(
	.clk(clk),
	.rst(rst),
	.en(if_en),
	.alu_result(alu_result),
	.taken(taken),

	.pc(pc),
	.pcn(pcn)
);

	wire de_en,alu_src_1_ctr,alu_src_2_ctr,jalx,reg_we,mem_we,rs1_need,rs2_need;
	wire [1:0]wb_ctr;
	wire [2:0]op;
	wire [3:0]branch,alu_ctr;
	wire [4:0]rs1,rs2,rd;
	wire [DATA_WITDH-1:0]imm,rd1,rd2;
	wire [ADDR_WITDH-1:0]pc,pcn,pcd,pcnd;

	wire reg_wew;//
	wire de_rst;
	wire [4:0]rdw;
	wire [DATA_WITDH-1:0]result;
	de u_de(
	.clk(clk),
	.rst(rst | de_rst),
	.en(de_en),
	.instr(instr),
	.pc(pc),
	.pcn(pcn),
	.rdw(rdw),
	.wew(reg_wew),
	.wdw(result),//declare when wb

	.rs1(rs1),
	.rs2(rs2),
	.rd(rd),
	.branch(branch),
	.imm(imm),
	.alu_src_1_ctr(alu_src_1_ctr),
	.alu_src_2_ctr(alu_src_2_ctr),
	.alu_ctr(alu_ctr),
	.jalx(jalx),
	.op(op),
	.reg_we(reg_we),
	.mem_we(mem_we),
	.pcnd(pcnd),
	.pcd(pcd),
	.rd1(rd1),
	.rd2(rd2),
	.wb_ctr(wb_ctr),
	.rs1_need(rs1_need),
	.rs2_need(rs2_need)
);

	wire reg_wee,mem_wee;
	wire [1:0]wb_ctre;
	wire [2:0]ope;
	wire [4:0]rde,rs1e,rs2e;
	wire [DATA_WITDH-1:0]rd2_ture;
	wire [ADDR_WITDH-1:0]pcne;

	wire [DATA_WIDTH-1:0]result,
	wire [1:0]rd1_ctr,
	wire [1:0]rd2_ctr,

	wire ex_rst,
	ex u_ex(
	 .clk(clk), 
	 .rst(rst | ex_rst), 
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

	 .alu_resultm(alu_resultm),
	 .result(result),
	 .rd1_ctr(rd1_ctr),
	 .rd2_ctr(rd2_ctr),


	 .reg_wee(reg_wee),
	 .ope(ope),
	 .mem_wee(mem_wee),
	 .rde(rde),
	 .pcne(pcne),
	 .taken(taken),
 	 .alu_result(alu_result),
	 .rd2_ture(rd2_ture),
	 .wb_ctre(wb_ctre),
	 .rs1e(rs1e),
	 .rs2e(rs2e)
);

	//[DATA_WITDH-1:0][3:0]wmask

	wire reg_wem; 
	wire [1:0]wb_ctrm;
	wire [4:0]rdm;
	wire [DATA_WITDH-1:0]data_out;
	wire [ADDR_WITDH-1:0]pcnm;

	mem u_mem(
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
	.data_in(data_in),

	.reg_wem(reg_wem),
	.rdm(rdm),
	.pcnm(pcnm),
 	.alu_resultm(alu_resultm),
	.wb_ctrm(wb_ctrm),

	.wmask(wmask),
	.mem_wem(mem_wem),
	.rd2_turem(rd2_turem),
	.data_out(data_out)

);

	wb u_wb(
	.clk(clk),
	.rst(rst),
	.reg_wem(reg_wem),
	.rdm(rdm),
	.pcnm(pcnm),
 	.alu_resultm(alu_resultm),
	.wb_ctrm(wb_ctrm),
	.data_out(data_out),

	.reg_wew(reg_wew),
	.[4:0]rdw(rdw),
	.[DATA_WITDH-1:0]result(result)
);

	forward u_forward(
	.rdm(rdm),
	.reg_wem(reg_wem),
	.rdw(rdw),
	.reg_wew(reg_wew),
	.rs1e(rs1e),
	.rs2e(re2e),
	
	.rd1_ctr(rd1_ctr),
	.rd2_ctr(rd2_ctr)
);

	stall_flush u_stall_flush(
	.wb_ctre(wb_ctre),
	.rde(rde),
	.rs1(rs1),
	.rs2(rs2),
	.taken(taken),
	.rs1_need(rs1_need),
	.rs2_need(rs2_need),

	.if_en(if_en),
	.de_en(de_en),
	.ex_rst(ex_rst),
	.de_rst(de_rst)
);

endmodule
