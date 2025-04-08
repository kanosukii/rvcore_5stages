module data_memory_ctr#(
	parameter DATA_WIDTH = 32,
)
(
	input [2:0]op,
	input [DATA_WIDTH-1:0]data_in,
	output [3:0]wmask,
	output [DATA_WIDTH-1:0]data_out
);
//read lb lh lw lbu lhu
	reg [DATA_WIDTH-1:0]data_out_temp;
	always @(*)begin
	data_out_temp = data_in;	
	if(op == 3'b000) data_out_temp = {{24{data_in[7]}},data_in[7:0]};
	if(op == 3'b001) data_out_temp = {{16{data_in[15]}},data_in[15:0]};
	if(op == 3'b010) data_out_temp = data_in; 
	if(op == 3'b100) data_out_temp = {{24'b0},data_in[7:0]};
	if(op == 3'b101) data_out_temp = {{16'b0},data_in[15:0]};
end
	data_out = data_out_temp;	
//write sb sh sw
	wire [3:0]wmask;
	assign wmask = (op == 3'b000) ? 4'b0001 : ((op == 3'b001) ? 4'b0011 : 4'b1111);
endmodule
