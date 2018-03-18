.data:
buffer: .space 100
table: .space 26

.text
main:
li $v0, 8
la $a0, buffer
li $a1, 100
syscall
la $t0, buffer

func:
lbu $t1, ($t0)
bltu $t1, 'a', label_1
addiu $t3, $t1, -97
la $t4, table
addu $t3, $t3, $t4
li $v0, 11 # wypisanie litery
ori $a0, $t1, 0
syscall

lb $a0, ($t3)
addiu $a0, $a0, 1
sb $a0, ($t3)

li $v0, 1
syscall

addiu $t0, $t0, 1
j func

label_1:
li $v0, 10
syscall
