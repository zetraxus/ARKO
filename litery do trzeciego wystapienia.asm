.data
buffer: .space 100
table: .space 26 #tylko male znaki

.text
li $v0, 8
la $a0, buffer
la $a1, 100
syscall
ori $t1, $0, 0

main:
lbu $t0, buffer($t1)
bltu $t0, 'a', exit

li $v0, 11
la $a0, ($t0)
syscall

addiu, $t0, $t0, -97
lb $t2, table($t0)
addiu $t2, $t2, 1
li $v0, 1
la $a0, ($t2)
syscall
sb $t2, table($t0)
bgeu $t2, 3, exit
addiu $t1, $t1, 1
j main

exit:
li $v0, 10
syscall

