.data
    space: .asciiz " " # Newline character

.text
    .globl main

main:
    # Prompt the user to enter a number
    li $v0, 4
    la $a0, msg
    syscall

    # Read the user's input
    li $v0, 5
    syscall

    # Store the input number in $t0
    move $t0, $v0

    # Initialize $t1 to 1 (start checking factors from 1)
    li $t1, 1
    li $t3,0
    li $t4,5
    

loop:
    # Check if $t1 is greater than the input number
    bgt  $t1, $t0, done
    
    #check if given numbers are printed
    bge $t3,$t4,done

    # Divide the input number by $t1 and check the remainder
    div $t0, $t1
    mfhi $t2
    # If remainder is 0, $t1 is a factor
    beqz  $t2, print_factor
    # Otherwise, continue checking the next number
    addi $t1, $t1, 1

    j loop

print_factor:
    # Print the factor
    li $v0, 1
    move $a0, $t1
    syscall

    # Print a newline
    li $v0, 4
    la $a0, space
    syscall

    # Continue checking the next number
    addi $t1, $t1, 1
    #increase counter
    addi $t3,$t3,1
    j loop

done:
    # Exit the program
    li $v0, 10
    syscall

.data
msg: .asciiz "Enter a number: "
