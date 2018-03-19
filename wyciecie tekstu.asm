# wyciecie tekstu od pierwszego do drugiego wystapienia litery a
.data
buffer: .space 100

.text
li $v0, 8
la $a0, buffer
la $a1, 100
syscall

la $t1, buffer

start:
lbu $t0, ($t1)
bltu $t0, ' ', exit
beq $t0, 'a', continue
addiu $t1, $t1, 1
j start

continue:
addiu $t1, $t1, 1
lbu $t0, ($t1)
bltu $t0, ' ', exit
beq $t0, 'a', exit

li $v0, 11
la $a0, ($t0)
syscall

j continue

exit:
li $v0, 10
syscall