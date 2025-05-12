module alu(
	input [3:0]ctr,
	input [31:0]a,
	input [31:0]b,
	output [31:0]result,
	output less,
	output zero
);
//decode unit
	wire add,sub,sll,slt,sltu,xori,srl,sra,ori,andi;
	alu_decode u_alu_decode(
	.ctr(ctr),
	.add(add),
	.sub(sub),
	.sll(sll),
	.slt(slt),
	.sltu(sltu),
	.xori(xori),
	.srl(srl),
	.sra(sra),
	.ori(ori),
	.andi(andi)
);
//adder unit
	wire cin = (sub | slt | sltu);// cin will be 1'b1 if it needs sub op
	wire [31:0]sum;
	wire carry,overflow,adder_zero;
	adder u_adder(
	.a(a),
	.b(b^{32{cin}}),
	.cin(cin),
	.sum(sum),
	.carry(carry),
	.zero(adder_zero),
	.overflow(overflow)
);
	wire less_sign,less_unsign;
	assign less_sign = overflow ^ sum[31];
	assign less_unsign = !carry;
//shift unit
	wire [1:0]shift_type;
	wire [31:0]shift;
	assign shift_type = (sra) ? 2'b11 : (srl ? 2'b01 : 2'b00);
	barrel_shifter u_barrel_shifter(
	.data_in(a),
	.shift_amt(b[4:0]),
	.shift_type(shift_type),
	.data_out(shift)
);
//out unit
	reg [31:0]result_temp;
	always @(*)begin
	result_temp = 32'b0; 
	if(add | sub) 			result_temp = sum;
	if(sll | srl | sra) result_temp = shift;
	if(slt | sltu) 			result_temp = {{31{1'b0}}, less};
	if(xori)					  result_temp = a ^ b;
	if(ori) 						result_temp = a | b;
	if(andi)				  	result_temp = a & b;
end

	assign result = result_temp;
	assign less = sltu ? less_unsign : less_sign;	
	assign zero = adder_zero;
endmodule
