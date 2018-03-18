.data:
buffer: .space 100

.text
main:
li $v0, 8
la $a0, buffer
li $a1, 100
syscall
la $t0, buffer
lbu $t1, ($t0)

label_1:
beq $t1, ' ', label_2
bltu $t1, ' ', end
and $t1, 65503

label_2:
sb $t1, ($t0)
addiu $t0, $t0, 1
lbu $t1, ($t0)
j label_1

end:
li $v0, 4
la $a0, buffer
syscall
la $v0, 10
syscall
