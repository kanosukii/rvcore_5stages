module de_dff#(
	parameter DATA_WIDTH = 32
)
(
	input clk,
	input rst,
	input en,
	input [DATA_WIDTH-1:0]pcn,
	input [DATA_WIDTH-1:0]pc,
	input [DATA_WIDTH-1:0]instr,
	output [DATA_WIDTH-1:0]pcnd,
	output [DATA_WIDTH-1:0]pcd,
	output [DATA_WIDTH-1:0]instrd
);
	reg [DATA_WIDTH-1:0]pcn_temp,pc_temp,instr_temp;
	always @(posedge clk) begin
	if(rst) begin
		pcn_temp <= {DATA_WIDTH{1'b0}};
		pc_temp <= {DATA_WIDTH{1'b0}}; 
		instr_temp <= {DATA_WIDTH{1'b0}}; 
		end
	else begin
		if(en) begin
			pcn_temp <= pcn;
			pc_temp <= pc;
			instr_temp <= instr;
		end
	end
end
	assign pcnd = pcn_temp;
	assign pcd = pc_temp;
	assign instrd = instr_temp;
endmodule
