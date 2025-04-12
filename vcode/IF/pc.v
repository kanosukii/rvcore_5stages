module pc#(
	parameter ADDR_WIDTH = 32,
	parameter DATA_WIDTH = 32
)(
	input clk,
	input rst,
	input en,
	input [DATA_WIDTH-1:0]alu_result,
	input taken,
	output [ADDR_WIDTH-1:0]pc,
	output [ADDR_WIDTH-1:0]pcn
);
	reg [ADDR_WIDTH-1:0]pc_temp;
	wire [ADDR_WIDTH-1:0]next_pc;

	assign next_pc = taken ? alu_result : pcn;

	always @(posedge clk)begin
	if(rst)	pc_temp <= {ADDR_WIDTH{1'b0}};
	else if(en) pc_temp <= next_pc;	
end

	assign pc = pc_temp;
	assign pcn = pc + {{(ADDR_WIDTH-4){1'b0}},4'd4};
endmodule
