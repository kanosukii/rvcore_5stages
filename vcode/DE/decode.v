module decode#(
	parameter ADDR_WIDTH = 32,
	parameter DATA_WIDTH = 32
)(
	input [ADDR_WIDTH-1:0]instr,
	output [4:0]rs1,
	output [4:0]rs2,
	output [4:0]rd,
	output [3:0]branch,
	output [DATA_WIDTH-1:0]imm,
	output alu_src_a,// 1'b0 rs1 1'b1 pc
	output alu_src_b,// 1'b0 rs2 1'b1 imm 
	output [3:0]alu_ctr,
	output jalx
	output [2:0]op,
	output reg_we,
	output mem_we,
);
// rs1 rs2 rd
	assign rs1 = (op_0110111) ? 5'b0 : instr[19:15];
	assign rs2 = instr[24:20];
	assign rd = instr[11:7];
	
	wire [6:0]opcode;
	wire [2:0]func3; 
	wire [6:0]func7;
	wire [DATA_WIDTH-1:0]immI,immU,immS,immB,immJ;

	assign opcode = instr[6:0];
	assign func3 = isntr[14:12];
	assign func7 = instr[31:25];
	
	assign immI = {{20{instr[31]}},instr[31:20]};
	assign immU = {instr[31:12],12'b0};
	assign immJ = {{12{instr[31]}},instr[19:12],instr[20],instr[30:21],1'b0};
	assign immB = {{20{instr[31]}},instr[7],instr[30:25],instr[11:8],1'b0};
	assign immS = {{20{instr[31]}},instr[31:25],instr[11:7]};
	
	wire op_0110111 = (opcode == 7'b0110111);
	wire op_0010111 = (opcode == 7'b0010111);
	wire op_1100111 = (opcode == 7'b1100111);
	wire op_0000011 = (opcode == 7'b0000011);
	wire op_0010011 = (opcode == 7'b0010011);
	wire typeB,typeU,typeJ,typeI,typeR,typeS;
	assign typeB = (opcode == 7'b1100011);
	assign typeU = op_0110111 | op_0010111;
	assign typeJ = (opcode == 7'b1101111); 
	assign typeI = op_1100111 | op_0000011 | op_0010011;
	assign typeS = (opcode == 7'b0100011);
	assign typeR = (opcode == 7'b0110011);
//branch imm
	assign branch = {typeB,func3};
	reg [DATA_WIDTH-1:0]imm_temp;
	always @(*)begin
	imm_temp = DATA_WIDTH'b0;
	if(typeB) imm_temp = immB;
	if(typeU) imm_temp = immU;
	if(typeJ) imm_temp = immJ;
	if(typeI) imm_temp = immI;
	if(typeS) imm_temp = immS;
end
	assign imm = imm_temp;	

//alu_src_a alu_src_b     when typeB alu prodece target pc
	assign alu_scr_a = (op_0010111 | typeJ | typeB);
	assign alu_scr_b = ~(typeR);

//alu_ctr
	wire func3_101 = (func3 == 3'b101);
	reg [3:0]alu_ctr_temp;
	always @(*)begin
	alu_ctr_temp = 4'b0000;
//	if(typeU || typeJ || ) alu_ctr_temp = 4'b0000;
	if(typeR || typeI) 	  alu_ctr_temp[2:0] = func3;
	if(typeR || (typeI && func3_101)) alu_ctr_temp[3] = instr[30];
end
	assign alu_ctr = alu_ctr_temp;

//jalx op reg_we mem_we
	assign jalx = typeJ | op_1100111;
	assign op = func3;
	assign reg_we = ~(typeB | typeS);
	assign mem_we = typeS;
endmodule
