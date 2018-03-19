.data
buffer: .space 100

.text
li $v0, 8
la $a0, buffer
la $a1, 100
syscall
la $t1, buffer

main:
lbu $t0, ($t1)
bltu $t0, 48, end
bltu, $t0, 97, label_1
addiu $t0, $t0, -49
j print

label_1:
addiu $t0, $t0, 49

print:
li $v0, 11
la $a0, ($t0)
syscall
addiu $t1, $t1, 1
j main

end:
li $v0, 10
syscall