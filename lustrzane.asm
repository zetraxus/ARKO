.data
buffer: .space 100

.text
load_data:
li $v0, 8
la $a0, buffer
la $a1, 100
syscall

li $t1, 97
addiu $t2, $t1, 122 # w t2 suma 97 + 122
ori $t1, $0, 0 # przesunecie liczone od zera


main:
lbu $t0, buffer($t1)
bltu $t0, 'a', exit
subu $t0, $t2, $t0

li $v0, 11
la $a0, ($t0)
syscall

addiu $t1, $t1, 1
j main

exit:
li $v0, 10
syscall
