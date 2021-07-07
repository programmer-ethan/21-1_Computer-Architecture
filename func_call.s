	.text
	.globl	main

main:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	la $a0, hello_msg
	jal print_msg
	
	li $s0, 11
	jal leaf_func

	li $s0, 22
	jal non_leaf_func

	lw $ra, 0($sp)
	addi $sp, $sp, 4

	jr $ra

#	li $v0, 10
#	syscall

leaf_func:
	addi $sp, $sp, -4
	sw $s0, 0($sp)

	# do someting here
	
	lw $s0, 0($sp)
	addi $sp, $sp, 4
	jr $ra

non_leaf_func:
	addi $sp, $sp, -8
	sw $s0, 0($sp)
	sw $ra, 4($sp)
	
	la $a0, non_leaf_msg
	jal print_msg
	
	li $a0, 777
	jal print_int
	
	lw $ra, 4($sp)
	lw $s0, 0($sp)
	addi $sp, $sp, 8
	jr $ra


print_int:
	li $v0, 1
	syscall
	jr $ra

print_msg:
	li $v0, 4
	syscall
	jr $ra

	.data
hello_msg:	.asciiz	"Hello World!!! \n"	
leaf_msg: 		.asciiz	"In the leaf_func \n"
non_leaf_msg: 	.asciiz	"In the Non-leaf func \n"
