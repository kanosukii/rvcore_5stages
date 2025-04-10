module ex_dff#(
	parameter DATA_WITDH = 32,
	parameter ADDR_WIDTH = 32
)(
	input clk, 
	input rst, 
	input reg_we,//1
	input [DATA_WITDH-1:0]imm,//33
	input jalx,//34
	input [3:0]branch,//38
	input alu_src_1_ctr,//39
	input alu_src_2_ctr,//40
	input [3:0]alu_ctr,//44
	input [2:0]op,//47
	input mem_we,//48
	input [4:0]rd,//53
	input [ADDR_WITDH-1:0]pcnd,//85
	input [ADDR_WITDH-1:0]pcd,//117
	input [DATA_WITDH-1:0]rd1,//149
	input [DATA_WITDH-1:0]rd2,//181
	input [4:0]rs1,//186
	input [4:0]rs2,//191
	input [1:0]wb_ctr,//193

	output reg_wee,
	output [DATA_WITDH-1:0]imme,
	output jalxe,
	output [3:0]branche,
	output alu_src_1_ctre,
	output alu_src_2_ctre,
	output [3:0]alu_ctre,
	output [2:0]ope,
	output mem_wee,
	output [4:0]rde,
	output [ADDR_WITDH-1:0]pcne,
	output [ADDR_WITDH-1:0]pce,
	output [DATA_WITDH-1:0]rd1e,
	output [DATA_WITDH-1:0]rd2e,
	output [4:0]rs1e,
	output [4:0]rs2e,
	output [1:0]wb_ctre
);
	reg [192:0]dff;
	always @(posedge clk) begin
		if(rst) begin
			dff <= 192'b0;
	end
		else begin
			dff <= {reg_we,imm,jalx,branch,alu_src_1_ctr,alu_src_2_ctr,alu_ctr,op,mem_we,rd,pcn,pc,rd1,rd2,rs1,rs2,wb_ctr}; 
	end
end

	assign {reg_wee,imme,jalxe,branche,alu_src_1_ctre,alu_src_2_ctre,alu_ctre,ope,mem_wee,rde,pcne,pce,rd1e,rd2e,rs1e,rs2e,wb_ctre} = dff;
endmodule
