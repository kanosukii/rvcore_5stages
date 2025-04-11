.section .text
.global _start

_start:
    li x1, 10
    li x2, 20
    li x3, 30
    li x4, -8
    
    add x5, x1, x2
    sub x6, x3, x2
    sll x7, x2, x1
    slt x8, x3, x4
    sltu x9, x3, x4
    xor x10, x1, x2
    srl x11, x3, x2
    sra x12, x4, x1
    or x13, x1, x2
    and x14, x1, x2
    
    addi x15, x1, 10
    slti x16, x4, -20
    sltiu x17, x4, -20
    xori x18, x1, 15
    ori x19, x1, 15
    andi x20, x2, 3
    slli x21, x3, 1
    srli x22, x4, 5
    srai x23, x4, 5
    lui x24, 23
    # ---- 加载/存储 ----
		auipc x25, 0x0
	  addi x25, x25, 20	
		jalr x26, x25, 4
		nop
		nop
temp:
		nop
		li x26, 0x87654321
    sw x26, 0(x0)     # 存储数据
		lb x27, 0(x0)
		lbu x27, 0(x0) 
		sh x26, 4(x0) 
		lh x27, 4(x0)
		lhu x27, 4(x0)
		sb x26, 8(x0)
		lw x27, 8(x0)
		

    # ---- 分支跳转 ----
blabel1:
    beq x1, x2, label1  # if (x1 == x2) 跳转到 label1
		nop
		li x27, 0
blabel2:
    bne x1, x2, label2  # if (x1 != x2) 跳转到 label2
		nop
		li x27, 1
blabel3:
    blt x3, x1, label3  # if (x3 < x1) 跳转到 label3
		nop
		li x27, 2
blabel4:
    bge x1, x2, label4  # if (x1 >= x2) 跳转到 label4
		nop
		li x27, 3
blabel5:
		bltu x1, x4, label5
		nop
		li x27, 4 
blabel6:
		bgeu x1, x4, label6
		nop
		li x27, 5 

label1:
    j blabel2  # 直接跳转到结束

label2:
    j blabel3

label3:
    j blabel4

label4:
    j blabel5

label5:
    j blabel6

label6:
    j label_end

label_end:
    nop                # 空操作 (停止执行)
    j label_end        # 死循环

