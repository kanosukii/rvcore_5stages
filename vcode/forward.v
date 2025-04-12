module forward(
	input [4:0]rdm,
	input reg_wem,
	input [4:0]rdw,
	input reg_wew,
	input [4:0]rs1e,
	input [4:0]rs2e,
	
	output [1:0]rd1_ctr,
	output [1:0]rd2_ctr
);
	wire rs1e_flag = | rs1e;// if rs1 == 5'd0
	wire rs2e_flag = | rs2e;// if rs2 == 5'd0

	assign rd1_ctr = ((rdm == rs1e) && reg_wem && rs1e_flag) ? 2'b01 : (((rdw == rs1e) && reg_wew && rs1e_flag) ? 2'b11 :2'b00);

	assign rd2_ctr = ((rdm == rs2e) && reg_wem && rs2e_flag) ? 2'b01 : (((rdw == rs2e) && reg_wew && rs2e_flag) ? 2'b11 :2'b00);
endmodule
