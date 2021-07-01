.text	         # text section
.globl main       # call main by SPIM

main:
		la		$t0, num #t0�� mum address�� �ҷ��´�.
		lw		$s0, 0($t0) #s0�� num word�� load�Ѵ�.
		lw		$s1, 4($t0) #s1�� even_min word�� load�Ѵ�.
		lw		$s2, 8($t0) #s2�� ood_max word�� load�Ѵ�. 
		lw		$s3, 12($t0) #s3�� even_min_check word�� load�Ѵ�.
		lw		$s4, 16($t0) #s4�� odd_max_check word�� load�Ѵ�.

		la		$t1, values #t1�� �迭 �ּ� ����
		#lw		$t2, 0($t1) # values �迭�� ù��° ���� t2�� load�Ѵ�.
		li		$t3, 0 # �ݺ��� �����ϱ� ����, i=0
		li		$t4, 0x00000001 # 1->1�� and�������� Ȧ¦�� �����ϱ� ���ؼ�

		#at�� �����Ϸ� �����̶� ���� ������� ���� t5�� �ӽú��� ����

		slti	$t5, $s0, 1 # num�� 1���� ������ 
		bne		$t5, $zero, Error #Error�� ����.(������ ����)

		slti	$t5, $s0, 11 # num�� 10���ϸ�
		bne		$t5, $zero, loop #loop�� ����.(���� ����)

		j		Error # 10���� ũ�� Error�� ����.(������ ����)
 
loop:
		slt		$t5, $t3, $s0 # i�� num���� ���� ������
		beq		$t5, $zero, End # t5=0�̸�, End���� ����.(�ݺ� ����)

		# i<num�� ���� �ݺ� ����
		lw		$t2, 0($t1) # t2�� �迭�� i��° ��<- values[i]
		addi     $t3, $t3, 1 #i=i+1
		addi     $t1, $t1, 4 #t1�� t2�� �ּ�->�迭�� �����ּҷ� �̵�(4 ����Ʈ)

		and		$t5, $t2, $t4 #1�� bit by bit and ������ �����Ͽ� Ȧ����1, ¦���� 0�� t5�� ����
		beqz	$t5, evenMin #t5==0�̸�(¦��) evenMin���� branch
		j	OddMax #t5!=0�̸�(Ȧ��) evenMin���� branch




evenMin:
		ble		$t2, $s1, newEvenMin # values[i]<=even_min�̸� newEvenMin���� branch
		j		loop

newEvenMin:
		move	$s1, $t2 # even_min=values[i]
		addi	$s3, $zero, 1 #even_min_check=1
		j		loop

OddMax:
		ble		$s2, $t2, newOddMax # odd_max<=values[i]�̸� newOddMax�� branch
		j		loop

newOddMax:
		move	$s2, $t2 # odd_max=values[i]
		addi	$s4, $zero, 1 #odd_max_check=1
		j		loop

minCheckZero:
		addi	$s1, $zero, -1	#even_min=-1 <-¦�� ���� ������ �ʱ갪
		j		Exit
maxCheckZero:
		addi	$s2, $zero, 0 #odd_min=0 <-Ȧ�� ���� ������ �ʱ갪
		j		Exit
		
  

Error:
        li 		$v0, 4            # set the syscall number to 4 (print_string)
        la 		$a0, msg0       # set $a0 to the print msg0
        syscall   		
        li		$v0, 10          # set the syscall number to 10 (exit)
        syscall

End:   
		beqz	$s3, minCheckZero # if(even_min_check==0)�̸� minCheckZero���� branch
		beqz	$s4, maxCheckZero #else if(odd_max_check==0)�̸� maxCheckZero���� branch <-n�� �ּ� 1�̹Ƿ� Ȧ¦ �ϳ��� ���� <-else if
		j		Exit

Exit:
        li 		$v0, 4            # set the syscall number to 4 (print_string)
        la 		$a0, msg1       # set $a0 to the print msg1
        syscall
		li 		$v0, 1            # set the syscall number to 1 (print_integer)
        move 	$a0, $s0       # set $a0 to the print num
        syscall

        li 		$v0, 4            # set the syscall number to 4 (print_string)
        la 		$a0, msg2       # set $a0 to the print msg2
        syscall
		li 		$v0, 1            # set the syscall number to 1 (print_integer)
        move 	$a0, $s1       # set $a0 to the print even_min
        syscall

        li 		$v0, 4            # set the syscall number to 4 (print_string)
        la 		$a0, msg3       # set $a0 to the print msg3
        syscall
		li 		$v0, 1            # set the syscall number to 1 (print_integer)
        move 	$a0, $s2       # set $a0 to the print odd_max
        syscall

        li		$v0, 10          # set the syscall number to 10 (exit)
        syscall


.data          	 # data section
num:	.word      10
even_min: .word     0x7fffffff #signed 32bit max��
odd_max: .word      0x80000000 #signed 32bit min��
even_min_check: .word	0 #even_min�� �ѹ��̶� ����Ǿ����� Ȯ���ϱ� ���� ����
odd_max_check: .word	0 #odd_max�� �ѹ��̶� ����Ǿ����� Ȯ���ϱ� ���� ����
values: .word 	    -1, 0, 1, -2, 3, -4, 5, -6, 7, 521   	  # variables used for this program
msg0:   .asciiz     "num should be in range 1~10"
msg1:   .asciiz     "Size of Array is "
msg2:   .asciiz     "\neven_min is "
msg3:   .asciiz     "\nodd_max is "