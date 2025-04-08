module barrel_shifter (
    input  wire [31:0] data_in,  // Input data
    input  wire [4:0]  shift_amt, // Shift amount (5 bits → up to 31)
    input  wire [1:0]  shift_type, // Shift type: 00 = SLL, 01 = SRL, 11 = SRA
    output wire [31:0] data_out   // Shifted output
);

    wire [31:0] stage1, stage2, stage3, stage4, stage5;

    // Stage 0: Shift by 16 if shift_amt[4] is 1
    assign stage1 = shift_amt[4] ? (shift_type == 2'b00 ? data_in << 16 : 
                                   (shift_type == 2'b01 ? data_in >> 16 : 
                                    {{16{data_in[31]}}, data_in[31:16]})) : data_in;

    // Stage 1: Shift by 8 if shift_amt[3] is 1
    assign stage2 = shift_amt[3] ? (shift_type == 2'b00 ? stage1 << 8 : 
                                   (shift_type == 2'b01 ? stage1 >> 8 : 
                                    {{8{stage1[31]}}, stage1[31:8]})) : stage1;

    // Stage 2: Shift by 4 if shift_amt[2] is 1
    assign stage3 = shift_amt[2] ? (shift_type == 2'b00 ? stage2 << 4 : 
                                   (shift_type == 2'b01 ? stage2 >> 4 : 
                                    {{4{stage2[31]}}, stage2[31:4]})) : stage2;

    // Stage 3: Shift by 2 if shift_amt[1] is 1
    assign stage4 = shift_amt[1] ? (shift_type == 2'b00 ? stage3 << 2 : 
                                   (shift_type == 2'b01 ? stage3 >> 2 : 
                                    {{2{stage3[31]}}, stage3[31:2]})) : stage3;

    // Stage 4: Shift by 1 if shift_amt[0] is 1
    assign stage5 = shift_amt[0] ? (shift_type == 2'b00 ? stage4 << 1 : 
                                   (shift_type == 2'b01 ? stage4 >> 1 : 
                                    {{1{stage4[31]}}, stage4[31:1]})) : stage4;

    assign data_out = stage5; // Final shifted output

endmodule
