.text	         # text section
.globl main       # call main by SPIM

main:
		la		$t0, num #t0에 mum address를 불러온다.
		lw		$s0, 0($t0) #s0에 num word를 load한다.
		lw		$s1, 4($t0) #s1에 even_min word를 load한다.
		lw		$s2, 8($t0) #s2에 ood_max word를 load한다. 
		lw		$s3, 12($t0) #s3에 even_min_check word를 load한다.
		lw		$s4, 16($t0) #s4에 odd_max_check word를 load한다.

		la		$t1, values #t1에 배열 주소 저장
		#lw		$t2, 0($t1) # values 배열의 첫번째 값을 t2에 load한다.
		li		$t3, 0 # 반복을 제어하기 위한, i=0
		li		$t4, 0x00000001 # 1->1과 and연산으로 홀짝을 구분하기 위해서

		#at는 컴파일러 전용이라 사용시 경고문구가 떠서 t5로 임시변수 지정

		slti	$t5, $s0, 1 # num이 1보다 작으면 
		bne		$t5, $zero, Error #Error로 간다.(비정상 동작)

		slti	$t5, $s0, 11 # num이 10이하면
		bne		$t5, $zero, loop #loop로 간다.(정상 동작)

		j		Error # 10보다 크면 Error로 간다.(비정상 동작)
 
loop:
		slt		$t5, $t3, $s0 # i가 num보다 작지 않으면
		beq		$t5, $zero, End # t5=0이면, End으로 간다.(반복 종료)

		# i<num인 동안 반복 실행
		lw		$t2, 0($t1) # t2는 배열의 i번째 값<- values[i]
		addi     $t3, $t3, 1 #i=i+1
		addi     $t1, $t1, 4 #t1은 t2의 주소->배열의 다음주소로 이동(4 바이트)

		and		$t5, $t2, $t4 #1과 bit by bit and 연산을 수행하여 홀수면1, 짝수면 0을 t5에 저장
		beqz	$t5, evenMin #t5==0이면(짝수) evenMin으로 branch
		j	OddMax #t5!=0이면(홀수) evenMin으로 branch




evenMin:
		ble		$t2, $s1, newEvenMin # values[i]<=even_min이면 newEvenMin으로 branch
		j		loop

newEvenMin:
		move	$s1, $t2 # even_min=values[i]
		addi	$s3, $zero, 1 #even_min_check=1
		j		loop

OddMax:
		ble		$s2, $t2, newOddMax # odd_max<=values[i]이면 newOddMax로 branch
		j		loop

newOddMax:
		move	$s2, $t2 # odd_max=values[i]
		addi	$s4, $zero, 1 #odd_max_check=1
		j		loop

minCheckZero:
		addi	$s1, $zero, -1	#even_min=-1 <-짝수 값이 없을때 초깃값
		j		Exit
maxCheckZero:
		addi	$s2, $zero, 0 #odd_min=0 <-홀수 값이 없을때 초깃값
		j		Exit
		
  

Error:
        li 		$v0, 4            # set the syscall number to 4 (print_string)
        la 		$a0, msg0       # set $a0 to the print msg0
        syscall   		
        li		$v0, 10          # set the syscall number to 10 (exit)
        syscall

End:   
		beqz	$s3, minCheckZero # if(even_min_check==0)이면 minCheckZero으로 branch
		beqz	$s4, maxCheckZero #else if(odd_max_check==0)이면 maxCheckZero으로 branch <-n은 최소 1이므로 홀짝 하나는 존재 <-else if
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
even_min: .word     0x7fffffff #signed 32bit max값
odd_max: .word      0x80000000 #signed 32bit min값
even_min_check: .word	0 #even_min이 한번이라도 변경되었는지 확인하기 위한 변수
odd_max_check: .word	0 #odd_max가 한번이라도 변경되었는지 확인하기 위한 변수
values: .word 	    -1, 0, 1, -2, 3, -4, 5, -6, 7, 521   	  # variables used for this program
msg0:   .asciiz     "num should be in range 1~10"
msg1:   .asciiz     "Size of Array is "
msg2:   .asciiz     "\neven_min is "
msg3:   .asciiz     "\nodd_max is "