module branch#(
	parameter DATA_WITDH = 32
)
(
	input [3:0]branch,
	input jalx,
	input [DATA_WITDH-1:0]rd1,
	input [DATA_WITDH-1:0]rd2,
	output taken
);

	wire carry,zero,overflow;
	wire [31:0]sum;
	adder u_branch_adder(
	.a(rd1),
	.b(~rd2),
	.cin(1'b1),
	.sum(sum),
	.carry(carry),
	.zero(zero),
	.overflow(overflow)
);
	assign less_sign = overflow^sum[31];
	assign less_unsign = carry;

	reg btaken;
	always @(*)begin
	btaken = 1'b0;
	if(branch[2:1] == 2'b00) btaken = zero ^ branch[0];
	if(branch[2:1] == 2'b10) btaken = less_sign ^ branch[0];
	if(branch[2:1] == 2'b11) btaken = less_unsign ^ branch[0];
end

	assign taken = jalx || (branch[3] && btaken);
endmodule
