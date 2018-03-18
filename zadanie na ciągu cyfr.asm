.data:
buffer: .space 100

.text
load_data:
li $v0, 8
la $a0, buffer
li $a1, 100
# t3 suma -> nastepnie srednia
# t4 liczba cyfr
# t5 minimum
syscall

la $t0, buffer
li $t5, 9 # "wyzerowanie" minimum

main:
lbu $t1, ($t0)
bltu $t1, '0', end
addiu $t1, $t1, -48
addu $t3, $t3, $t1
addiu $t4, $t4, 1
addiu $t0, $t0, 1
bge $t1, $t5, main
ori $t5, $t1, 0
j main

end:
la $t0, buffer
div $t3, $t3, $t4 #srednia w t3

print:
lbu $t1, ($t0)
bltu $t1, '0', exit
addiu $t1, $t1, -48
blt $t1, $t3, podmiana_min
j ciag_dalszy

podmiana_min:
ori $t1, $t5, 0

ciag_dalszy:
li $v0, 1
ori $a0, $t1, 0
syscall
addiu $t0, $t0, 1
j print

exit:
li $v0, 10
syscall
