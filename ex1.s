.text	         # text section
.globl main       # call main by SPIM

main:   
        la     $t2, fvar
        lw     $s0, 0($t2)
        lw     $s1, 4($t2)
        lw     $s2, 8($t2)
        lw     $s3, 12($t2)
        lw     $s4, 16($t2)

        add     $t0, $s1, $s2
        add     $t1, $s3, $s4
        sub     $s0, $t0, $t1

        sw      $s0, 0($t2)

        move $a0, $s0
        li $v0, 1
        syscall

        jr $ra          # retrun to caller



.data          	 # data section
fvar: .word 	0   	  # variables used for this program
gvar: .word 	10
hvar: .word 	-5
ivar: .word 	6
jvar: .word 	3