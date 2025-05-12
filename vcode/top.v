module top#(
	parameter ADDR_WIDTH = 32,
	parameter DATA_WIDTH = 32
)(
	input clk,
	input rst
);
	wire [ADDR_WIDTH-1:0]instr;
	wire [DATA_WIDTH-1:0]data;
	wire [DATA_WIDTH-1:0]alu_resultm;
	wire [DATA_WIDTH-1:0]rd2_turem;
	wire [3:0]wmask;
	wire mem_wem;
	wire [ADDR_WIDTH-1:0]pc;

	cpu u_cpu(
	.clk(clk),
	.rst(rst),
	.instr(instr),
	.data(data),

	.alu_resultm(alu_resultm),
	.rd2_turem(rd2_turem),
	.wmask(wmask),
	.mem_wem(mem_wem),
	.pc(pc)
);

	instr_mem u_instr_mem(
	.addr(pc[17:2]),
	.data(instr)
);

	data_mem u_data_mem(
	.clk(clk),
	.addr(alu_resultm[14:0]),
	.data_in(rd2_turem),
	.wmask(wmask),
	.we(mem_wem),
	.data_out(data)
);

	wire [31:0]ebreak = 32'b0000_0000_0001_0000_0000_0000_0111_0011 ;
	always @(posedge clk)begin
	if(instr == ebreak)begin
		$display("[SIM] ebreak encounter\n");
		$finish;
	end
end

	initial begin
	$readmemh("./tcode/temp/test.hex",u_instr_mem.mem,0);
end
	
	initial begin
	if($test$plusargs("trace") != 0)begin
		$display("[%0t] Tracing to logs/vlt_dump.vcd...\n", $time);
		$dumpfile("logs/vlt_dump.vcd");
		$dumpvars();
	end
	$display("[%0t] Model running...\n", $time);
	end
endmodule
