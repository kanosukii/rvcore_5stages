module wb_dff
	parameter DATA_WITDH = 32,
	parameter ADDR_WITDH = 32
)
(
	input clk,
	input rst,

	input reg_wem,//1
	input [4:0]rdm,//6
	input [ADDR_WITDH-1:0]pcnm,//38
 	input [DATA_WITDH-1:0]alu_resultm,//70
	input [1:0]wb_ctrm,//72
	input [DATA_WITDH-1:0]data_out//104

	output reg_wew,
	output [4:0]rdw,
	output [ADDR_WITDH-1:0]pcnw,
 	output [DATA_WITDH-1:0]alu_resultw,
	output [1:0]wb_ctrw,
	output [DATA_WITDH-1:0]data_outw

);
	reg [103:0]temp;
	always @(posedge clk) begin
	if(rst) begin
		temp <= 103'b0;
	end
		temp <= {reg_wem,rdm,pcnm,alu_resultm,wb_ctrm,data_out};
end

	assign {reg_wew,rdw,pcnw,alu_resultw,wb_ctrw,data_outw} = temp;

endmodule
