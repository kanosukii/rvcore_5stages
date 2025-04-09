module register#(
	parameter DATA_WITDH = 32
)(
	input clk,
	input [4:0]rs1,
	input [4:0]rs2,
	input [4:0]rd,
	input we,
	input [DATA_WITDH-1:0]wd,
	output [DATA_WITDH-1:0]rd1,
	output [DATA_WITDH-1:0]rd2
);
	reg [DATA_WITDH-1:0]mem[1:31];
	assign rd1 = (rs1 == 5'b0) ? 32'b0 : mem[rs1];
 	assign rd2 = (rs2 == 5'b0) ? 32'b0 : mem[rs2];
	
	always @(negedge clk) begin
		if(we && (rd !=5'b0)) begin
			mem[rd] <= wd;
	end
end
endmodule
