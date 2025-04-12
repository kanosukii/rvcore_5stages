module stall_flush(
	input [1:0]wb_ctre,//2'b11 data_mem
	input [4:0]rde,
	input [4:0]rs1,
	input [4:0]rs2,
	input taken,
	input rs1_need,
	input rs2_need,

	output if_en,
	output de_en,
	output ex_rst,
	output de_rst
);
	wire stall,flush;
//1'b0 rs1 rs2
//rs1_need = 

	assign stall = (wb_ctre == 2'b11) && (((rde == rs1) && rs1_need) || ((rde == rs2) && rs2_need));
	assign flush = taken;


	assign if_en = !stall;
	assign de_en = !stall;	
	assign ex_rst = stall | flush;
	assign de_rst = flush;

endmodule
