.data
str:      .space  100
prompt:   .asciiz "Enter a string: "
yes:      .asciiz "Palindrome"
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
    addi $s1, $s1, 99  # Set $s1 to the end of the buffer
    checkPalindromeLoop:
        beq $s0, $s1, isPalindrome  # If $s0 >= $s1, it's a palindrome

        lb $t0, 0($s0)   # Load a character from the start
        lb $t1, 0($s1)   # Load a character from the end

        bne $t0, $t1, notPalindrome  # If characters do not match, it's not a palindrome

        addi $s0, $s0, 1   # Move $s0 (start pointer) forward
        subi $s1, $s1, 1   # Move $s1 (end pointer) backward
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
   findLength:
       li $t0,0 #count
       loop:
       lb $t1, 0($a0)
       beqz $t1,done
       addi $a0,$a0,1 #string pointer
       addi $t0,$t0,1
   
    done:
        # Print a newline and exit
        li $v0, 4
        la $a0, newline
        syscall
        li $v0, 10
        syscall

