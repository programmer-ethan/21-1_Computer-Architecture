# revert a string


	.text
	.globl 	main

main:
	la $s0, src	# assign the starting address of src to $s0
	la $s1, dest	# assign the starting address of dest to $s1

#	li $s2, 14		# loop count 14 to $s2 as many as the length of string "Hello World!!!" (but NULL)
	li $s2, 13
	
	addi $s0, $s0, 13	# advance the $s0 to the last byte of the "Hello World!!!" (13 bytes later)

loop:	
#	beq $s2, $zero, Exit
	bltz $s2, Exit

	lb $t0, 0($s0)	
	sb $t0, 0($s1)

	addi $s2, $s2, -1
	addi $s0, $s0, -1	# why??? lb해야하니까. 
	addi $s1, $s1, 1	# why??? sb해야 하니까.

	j loop

Exit:
	
	li $v0, 4		# print string syscall 4
	la $a0, dest
	syscall

	jr $ra

	.data
src:	.asciiz	"Hello World!!!"
dest:	.space    50	# reserve 50 bytes for reverse string
