module pc(
	input clk,
	input rst,
	input en,
	input [31:0]alu_result,
	input taken,
	output [31:0]pc,
	output [31:0]pcn
);
	reg [31:0]pc_temp;
	wire [31:0]next_pc;

	assign next_pc = taken ? alu_result : pcn;

	always @(posedge clk)begin
	if(rst)	pc_temp <= 32'b0;
	else if(en) pc_temp <= next_pc;	
end

	assign pc = pc_temp;
	assign pcn = pc + 32'd4;
endmodule
