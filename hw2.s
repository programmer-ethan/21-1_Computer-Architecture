.text	         # text section
.globl main       # call main by SPIM

main:
	Addi $sp, $sp, -16
	Sw $ra, 0($sp)
	Sw $t0, 4($sp)
	Sw $t1, 8($sp)
	Sw $t2, 12($sp)
	Lui $t1, ???($zero)
	Lw $t0, 0($a0)
	slt $t2, $t0, $t1
	Bne $t2, $zero, 2
	Addu $t1, $zero, $t0
	Addi $a0, $a0, 4
	Addi $a1, $a1, -1
	Bne $a1, $zero, -6
	Addu $v0, $zero, $t1 
	Lw $t2, 12($sp)
	Lw $t1, 8($sp)
	Lw $t0, 4($sp)
	Lw $ra, 0($sp)
	Addi $sp, $sp, 16
	Jr $ra

.data          	 # data section
num:	.word      10