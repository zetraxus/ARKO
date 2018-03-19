.data
buffer: .space 100
table: .space 26

.text
load_data:
li $v0, 8
la $a0, buffer
la $a1, 100
syscall

la $t0, buffer

main:
lbu $t1, ($t0)
bltu $t1, 'a', print
addiu $t1, $t1, -97
la $t2, table
addu $t1, $t1, $t2
lb $t2, ($t1)
addiu $t2, $t2, 1
sb $t2, ($t1)
addiu $t0, $t0, 1
j main

print:
la $t0, table
li $t2, 97
addiu $t4, $t0, 26

loop:

bgtu $t0, $t4, end
lb $t1, ($t0)
beqz $t1, loop2

li $v0 11
la $a0, ($t2)
syscall

li $v0, 1
la $a0, ($t1)
syscall

loop2:
addiu $t0, $t0, 1
addiu $t2, $t2, 1
j loop

end:
li $v0, 10
syscall
