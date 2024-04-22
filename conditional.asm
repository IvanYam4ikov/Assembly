# conditional.asm
# A conditionally branching program in MIPS Assembly for CS64
#
#  Data Area - allocate and initialize variables
.data
	prompt: .asciiz "Enter an integer: "

#Text Area (i.e. instructions)
.text
main:

	# print a prompt
	li $v0 4
	la $a0 prompt
	syscall

	# get an input
	li $v0 5
	syscall
	move $s0 $v0

	# shift two bits right than two left
	# if numbers are the same, it is divisible by 4
	li $t0 2
	srl $t1 $s0 $t0
	sll $t2 $t1 $t0

	# go to not_div in not divisible by 4
	bne $t2 $s0 not_div
	#if equal, execute the following
	li $t3 4
	mul $s1 $s0 $t3
	li $v0 1
	move $a0 $s1
	syscall
	
	j exit
	
	# this is executed if not divisible
not_div:
	li $t3 7
	mul $s1 $s0 $t3
	li $v0 1
	move $a0 $s1
	syscall

	j exit

exit:
	# Exit SPIM
    li $v0, 10
    syscall

	

