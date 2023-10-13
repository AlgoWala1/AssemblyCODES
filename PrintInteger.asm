.data
mynum:.word 5
.text
li $v0,1
lw $a0,mynum
syscall
