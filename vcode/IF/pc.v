module pc#(
	parameter ADDR_WITDH = 32,
	parameter DATA_WITDH = 32
)(
	input clk,
	input rst,
	input en,
	input [DATA_WITDH-1:0]alu_result,
	input taken,
	output [ADDR_WITDH-1:0]pc,
	output [ADDR_WITDH-1:0]pcn
);
	reg [ADDR_WITDH-1:0]pc_temp;
	wire [ADDR_WITDH-1:0]next_pc;

	assign next_pc = taken ? alu_result : pcn;

	always @(posedge clk)begin
	if(rst)	pc_temp <= ADDR_WITDH'b0;
	else if(en) pc_temp <= next_pc;	
end

	assign pc = pc_temp;
	assign pcn = pc + ADDR_WITDH'd4;
endmodule
