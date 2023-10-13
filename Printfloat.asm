.data
myfloat:.float 5.4
.text
li $v0,2
lwc1 $f12,myfloat
syscall
