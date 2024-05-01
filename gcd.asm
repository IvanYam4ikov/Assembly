# S24 CS 64 
# Lab 04
# gcd.asm 

##### C++ (NON-RECURSIVE) code snippet of gcd(a,b):
    # int main()
    # {
    #     int a, b, n;
    #     int gcd = 1;

    #     cout << "Enter the first number:\n"; 
    #     cin >> a;
    #     cout << "Enter the second number:\n"; 
    #     cin >> b;
        
    #     if(a<b)
    #     {    n = a; }
    #     else
    #     {    n = b; }

    #     for(int i = 1; i <= n; i++)
    #     {
    #         if(a%i==0 && b%i==0)
    #             gcd = i;
    #     }

    #     cout << "GCD: " << gcd <<  "\n"; 

    #     return 0;
    # }


##### Assembly (NON-RECURSIVE) code version of gcd(a,b):

.data

    first_num: .asciiz "Enter the first number:\n"
    second_num: .asciiz "Enter the second number:\n"
    gcd: .asciiz "GCD:\n"
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

    # gcd is in s2 and set it to 1
    li $s2 1
    
    bgt $s1 $s2 n_equals_a
    j n_equals_b

n_equals_a:

    move $s3 $s0
    j before_loop

n_equals_b:

    move $s3 $s1
    j before_loop

before_loop:

    li $t0 1
    move $t1 $s3
    j loop

loop:

    beq $t0 $t1 end_loop

    div $s0 $t0
    mfhi $t2
    div $s1 $t0
    mfhi $t3
    or $t4 $t2 $t3
    beq $t4 $zero gcd_found
    addi $t0 $t0 1
    j loop

gcd_found:

    move $s2 $t0
    addi $t0 $t0 1
    j loop

end_loop:

    li $v0 4
    la $a0 gcd
    syscall

    li $v0 1
    move $a0 $s2
    syscall

    la $a0 newline
    li $v0 4
    syscall
    
    j exit

exit:
	
    li $v0 10
    syscall
