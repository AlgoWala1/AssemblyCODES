.data
mynum: .word 20
mynum2: .word 30
.text
lw $t1,mynum
lw $t2,mynum2
add $a0,$t1,$t2
li $v0,1 #1 is for printing 
syscall
