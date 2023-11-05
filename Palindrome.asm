.data
str:      .space  100
prompt:   .asciiz "Enter a string: "
yes:      .asciiz "Is a Palindrome"
no:       .asciiz "Not a palindrome"
newline:  .asciiz "\n" 

.text
main:
    # Display a prompt to the user
    li $v0, 4
    la $a0, prompt
    syscall

    # Read a string from the user
    li $v0, 8
    la $a0, str
    li $a1, 100  # Maximum string length
    syscall

    # Initialize pointers and lengths
    la $s0, str          # Start of the string
    la $s1, str          # End of the string
    jal findLength
    subi $t0,$t0,1
    add $s1,$s1,$t0  # Set $s1 to the end of the buffer
    checkPalindromeLoop:
        beq $s0, $s1, isPalindrome  # If $s0 >= $s1, it's a palindrome
        lb $t2, 0($s0)   
        lb $t1, 0($s1)  
        bne $t1, $t2, notPalindrome  
        addi $s0, $s0, 1  
        subi $s1,$s1, 1   
        j checkPalindromeLoop

    isPalindrome:
        # Print "Palindrome" message
        li $v0, 4
        la $a0, yes
        syscall
        j done
    notPalindrome:
        # Print "Not a palindrome" message
        li $v0, 4
        la $a0, no
        syscall
        j done
   findLength:#will consider space as a character
       li $t0,-1 #count must be decreased hence
       loop:
       lb $t1, 0($a0)
       beqz $t1,return
       addi $a0,$a0,1 #string pointer
       addi $t0,$t0,1
       j loop
       
    return:
    jr $ra #jump back to the caller 
   
    done:
        # Print a newline and exit
        li $v0, 4
        la $a0, newline
        syscall
        li $v0, 10
        syscall

