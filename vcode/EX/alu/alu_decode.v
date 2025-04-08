module alu_decode(
	input [3:0]ctr,
	output add, //4'b0000
	output sub, //4'b1000
	output sll, //4'b0001
	output slt, //4'b0010
	output sltu,//4'b0011
	output xori,//4'b0100
	output srl, //4'b0101
	output sra, //4'b1101
	output ori, //4'b0110
	output andi //4'b0111
);

	assign add = (ctr == 4'b0000); 
	assign sub = (ctr == 4'b1000); 
	assign sll = (ctr == 4'b0001); 
	assign slt = (ctr == 4'b0010); 
	assign sltu= (ctr == 4'b0011); 
	assign xori= (ctr == 4'b0100); 
	assign srl = (ctr == 4'b0101); 
	assign sra = (ctr == 4'b1101); 
	assign ori = (ctr == 4'b0110); 
	assign andi= (ctr == 4'b0111); 
endmodule
