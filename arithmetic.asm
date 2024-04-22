# arithmetic.asm
# A simple calculator program in MIPS Assembly for CS64
#

.text
main:

	# Read x
	li $v0 5
	syscall
	move $s1 $v0

	# Read y
	li $v0 5
	syscall
	move $s2 $v0

	# (x - y / 2)
	li $t0 2
	div $s3 $s2 $t0
	sub $s4 $s1 $s3

	# 32 * (x - y / 2) + 4
	li $t1 5
	li $t2 4
	sll $s5 $s4 $t1
	add $s0 $s5 $t2

	# print the result
	li $v0 1
	move $a0 $s0
	syscall

	# go to exit
	j exit
exit:
	
	# exit
	li $v0 10
	syscall

