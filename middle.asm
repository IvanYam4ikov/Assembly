# S24 CS 64 
# Lab 04
# middle.asm 

.data

    first_num: .asciiz "Enter the first number:\n"
    second_num: .asciiz "Enter the second number:\n"
    third_num: .asciiz "Enter the third number:\n"
    middle: .asciiz "Middle:\n"
    newline: .asciiz "\n"

.text

main:
    # outputting the prompt
    li $v0 4
    la $a0 first_num
    syscall

    # taking the input from the user and moving to s0
    li $v0 5
    syscall
    move $s0 $v0 
    # s0 is the first number

    # outputting the prompt
    li $v0 4
    la $a0 second_num
    syscall

    # taking the input from the user and moving to s1
    li $v0 5
    syscall
    move $s1 $v0
    # s1 is the second number

    # outputting the prompt
    li $v0 4
    la $a0 third_num
    syscall

    # taking the input from the user and moving to s2
    li $v0 5
    syscall
    move $s2 $v0
    # s2 is the third number

    # save values for a>b, a>c, and b>c
    sgt $t0 $s0 $s1 # first > second in t0
    sgt $t1 $s0 $s2 # first > third in t1
    sgt $t2 $s1 $s2 # second > third in t2

    # also save values for combinations of these 
    and $t3 $t0 $t1 # first > second and first > third in t3
    not $t4 $t0 # second > first in t4
    and $t5 $t2 $t4 # second > third and second > first in t5
    not $t6 $t1 # third > first in t6
    not $t7 $t2 # third > second in t7
    and $t8 $t6 $t7 # third > first and third > second in t8

    # if t3 greater than 0 (first is the largest number)
    bgt $t3 $zero firstIsGreatest
    
    #if t5 is greater than 0 (second is the greatest number)
    bgt $t5 $zero secondIsGreatest

    j thirdIsGreatest

firstIsGreatest:

    # if second < third, third is middle
    beq $t2 $zero thirdIsMiddle
    # otherwise second is middle
    j secondIsMiddle

secondIsGreatest:
    
    # if third > first, third is middle
    beq $t1 $zero thirdIsMiddle
    # otherwise first is middle
    j firstIsMiddle

thirdIsGreatest:
    
    # if second > first, second is middle
    beq $t0 $zero secondIsMiddle
    # otherwise first is middle
    j firstIsMiddle

firstIsMiddle:

    la $a0 middle
    li $v0 4
    syscall

    move $a0 $s0
    li $v0 1
    syscall

    la $a0 newline
    li $v0 4
    syscall

    j exit

secondIsMiddle:

    la $a0 middle
    li $v0 4
    syscall

    move $a0 $s1
    li $v0 1
    syscall

    la $a0 newline
    li $v0 4
    syscall

    j exit

thirdIsMiddle:

    la $a0 middle
    li $v0 4
    syscall

    move $a0 $s2
    li $v0 1
    syscall

    la $a0 newline
    li $v0 4
    syscall
    
    j exit

exit:
    
    li $v0 10
    syscall
