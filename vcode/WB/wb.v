module wb#(
	parameter DATA_WIDTH = 32,
	parameter ADDR_WIDTH = 32
)
(
	input clk,
	input rst,

	input reg_wem,
	input [4:0]rdm,
	input [ADDR_WIDTH-1:0]pcnm,
 	input [DATA_WIDTH-1:0]alu_resultm,
	input [1:0]wb_ctrm,
	input [DATA_WIDTH-1:0]data_out,

	output reg_wew,
	output [4:0]rdw,
	output [DATA_WIDTH-1:0]result

);
	wire [ADDR_WIDTH-1:0]pcnw;
	wire [DATA_WIDTH-1:0]data_outw;
	wire [DATA_WIDTH-1:0]alu_resultw;
	wire [1:0]wb_ctrw;

	wb_dff u_wb_dff(
	.clk(clk),
	.rst(rst),
	.reg_wem(reg_wem),
	.rdm(rdm),
	.pcnm(pcnm),
	.alu_resultm(alu_resultm),
	.wb_ctrm(wb_ctrm),
	.data_out(data_out),

	.reg_wew(reg_wew),
	.rdw(rdw),
	.pcnw(pcnw),
	.alu_resultw(alu_resultw),
	.wb_ctrw(wb_ctrw),
	.data_outw(data_outw)
);

	assign result = (wb_ctrw == 2'b11) ?  data_outw : ((wb_ctrw == 2'b01) ? pcnw : alu_resultw);
endmodule
