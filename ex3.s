.text	         # text section
.globl main       # call main by SPIM

main:   
        li     $s0, 1
        li     $s1, 1
        li     $s2, 0
        li     $s3, 4

        bne     $s0, $s1, else1
        add     $s2, $zero, $s3
        j exit1
else1:
        sub     $s2, $zero, $s3
exit1:
        add     $s0, $zero, $zero
        bne     $s0, $s1, else2
        add     $s2, $zero, $s3
        j exit2
else2:
        sub $s2, $zero $s3
exit2:
        move $a0, $s0
        li $v0, 1
        syscall
        jr $ra