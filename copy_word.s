# copying a word array 


	.text
	.globl 	main

main:
	la $s0, src	# assign the starting address of src to $s0
	la $s1, dest	# assign the starting address of dest to $s1

	li $s2, 5		# loop count 5 to $s2
	
loop:	beq $s2, $zero, Exit

	lw $t0, 0($s0)	
	sw $t0, 0($s1)

	addi $s2, $s2, -1
	addi $s0, $s0, 4
	addi $s1, $s1, 4

	j loop

Exit:
	jr $ra

	.data
src:	.word	1, 2, 3, 4, 5
dest:	.word	0, 0, 0, 0, 0