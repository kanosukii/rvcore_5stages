module top#(
	parameter ADDR_WITDH = 32,
	parameter DATA_WITDH = 32
)(
	input clk,
	input rst
);
	wire [ADDR_WITDH-1:0]instr,
	wire [DATA_WITDH-1:0]data,
	wire [DATA_WITDH-1:0]alu_resultm,
	wire [DATA_WITDH-1:0]rd2_turem,
	wire [3:0]wmask,
	wire mem_wem,
	wire [ADDR_WITDH-1:0]pc,

	cpu u_cpu(
	.clk(clk),
	.rst(rst),
	.instr(instr),
	.data(data),

	.alu_resultm(alu_resultm),
	.rd2_turem(rd2_turem),
	.wmask(wmask),
	.mem_wem(mem_wem),
	.pc(pc)
);

	instr_mem u_instr_mem(
	.addr(pc),
	.data(instr)
);

	data_mem u_data_mem(
	.clk(clk),
	.addr(alu_resultm),
	.data_in(rd2_turem),
	.wmask(wmask),
	.we(mem_wem),
	.data_out(data)
);

endmodule
