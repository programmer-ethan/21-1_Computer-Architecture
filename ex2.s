.text	         # text section
.globl main       # call main by SPIM

main:   
        li     $s0, 0x000055AA
        li     $s1, 0x0000
        li     $s2, 0xAA550000

        sll     $t0, $s1, 4
        srl     $t1, $s2, 4
        sra     $t2, $s2, 4

        and     $t3, $s0, $s1
        or     $t4, $s0, $s1
        xor     $t5, $s0, $s1
        nor     $t6, $s0, $s1

        jr $ra          # retrun to caller