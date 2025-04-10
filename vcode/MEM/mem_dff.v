moulde mem_dff#(
	parameter DATA_WITDH = 32 ,
	parameter ADDR_WITDH = 32
)(
	input clk,
	input rst,
	input reg_wee,//1
	input [2:0]ope,//4
	input mem_wee,//5
	input [4:0]rde,//10
	input [ADDR_WITDH-1:0]pcne,//42
 	input [DATA_WITDH-1:0]alu_result,//74
	input [DATA_WITDH-1:0]rd2_ture,//106
	input [1:0]wb_ctre,//108

	output reg_wem,
	output [2:0]opm,
	output mem_wem,
	output [4:0]rdm,
	output [ADDR_WITDH-1:0]pcnm,
 	output [DATA_WITDH-1:0]alu_resultm,
	output [DATA_WITDH-1:0]rd2_turem,
	output [1:0]wb_ctrm

);
	reg [107:0]temp;
	always @(posedge clk) begin
	if(rst) begin
		temp <= 108'b0;
	end
		temp <= {reg_wee,ope,mem_wee,rde,pcne,alu_result,rd2_ture,wb_ctre};
end

	assign {reg_wem,opm,mem_wem,rdm,pcnm,alu_resultm,rd2_turem,wb_ctrm} = temp;
endmodule
