# print_array.asm program
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.data
# Data Area.  
# Note that while this is typically only for global immutable data, 
# for SPIM, this also includes mutable data.
# DO NOT MODIFY THIS SECTION
input: 
    .word 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
length:
    .word 15
fizz:   .asciiz "Fizz "
buzz:   .asciiz "Buzz "
fizzbuzz:   .asciiz "FizzBuzz "
space:  .asciiz " "
ack:    .asciiz "\n"


.text
FizzBuzz:
    move $t0 $a0
    move $t1 $a1

    li $t2 0    # i for a loop
    li $t5 3    # 3 for modulo 
    li $t6 5    # 5 for modulo

    loop:

        beq $t2 $t1 return  # if i == size, return
        lw $t4 0($t0)     # t4 for the value of the array
        div $t4 $t5         
        mfhi $t7            # the remainder from t4 % 3
        div $t4 $t6
        mfhi $t8            # the remainder from t4 % 5
        or $t9 $t7 $t8      # if t7 or t8 > 0, t9 > 0 too
        bne $t9 $zero mod5  # if t9 > 0 go to mod 5
        la $a0 fizzbuzz     # otherwise, print fizzbuzz
        li $v0 4
        syscall
        j add_one           # go to the next index

    mod5:               

        bne $t8 $zero mod3  # if mod 5 > 0, check for mod 3
        la $a0 buzz         # print buzz otherwise and go to the next index
        li $v0 4
        syscall
        j add_one

    mod3:

        bne $t7 $zero else  # if mod 3 > 0, go to the else branch
        la $a0 fizz         # print fizz otherwise    
        li $v0 4
        syscall
        j add_one

    else:

        move $a0 $t4          # print the number and space
        li $v0 1
        syscall
        la $a0 space
        li $v0 4
        syscall
        j add_one

    add_one:

        addi $t2 $t2 1      # move to the next index
        addi $t0 $t0 4
        j loop

    return:
        jr $ra


main:
    #DO NOT MODIFY THIS
    la $a0 input
    lw $a1 length
    jal FizzBuzz
    j exit

exit:
    la $a0 ack
    li $v0 4
    syscall
	li $v0 10 
	syscall

