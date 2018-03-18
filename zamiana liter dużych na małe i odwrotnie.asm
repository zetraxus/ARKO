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

func:
bleu $t1, 'Z', label_1
addiu $t1, $t1, -32
j label_2

label_1:
beq $t1, ' ', label_2
bltu $t1, ' ', end
addiu $t1, $t1, 32
j label_2

label_2:
sb $t1, ($t0)
addiu $t0, $t0, 1
lbu $t1, ($t0)
j func

end:
li $v0, 4
la $a0, buffer
syscall
la $v0, 10
syscall