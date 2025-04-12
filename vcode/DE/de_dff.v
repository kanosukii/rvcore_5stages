module de_dff#(
	parameter DATA_WIDTH = 32
)
(
	input clk,
	input rst,
	input en,
	input [DATA_WIDTH-1:0]pcn,
	input [DATA_WIDTH-1:0]pc,
	output [DATA_WIDTH-1:0]pcnd,
	output [DATA_WIDTH-1:0]pcd
);
	reg [DATA_WIDTH-1:0]pcn_temp,pc_temp;
	always @(posedge clk) begin
	if(rst) begin
		pcn_temp <= {DATA_WIDTH{1'b0}};
		pc_temp <= {DATA_WIDTH{1'b0}}; 
		end
	else begin
		if(en) begin
			pcn_temp <= pcn;
			pc_temp <= pc;
		end
	end
end
	assign pcnd = pcn_temp;
	assign pcd = pc_temp;
endmodule
