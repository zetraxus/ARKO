.data
# dane
input: .asciiz "example_input.bmp"
output: .asciiz "example_output.bmp"
.align 2 
header: .space 4
.align 2 
fileSize: .space 4
.align 2 
offset: .space 4
.align 2 
width: .space 4
.align 2 
height: .space 4

# komunikaty 
message_1: .asciiz "blad otwierania pliku"
message_2: .asciiz "poprawnie zakonczono program"

# $s0 fileSize
# $s1 offset
# $s2 width
# $s3 height

.text
######################################################################################################
openingFile:
# otwieranie pliku "example"
la $a0, input
li $a1, 0
li $a2, 0
li $v0, 13
syscall

move $t9, $v0 # przechowywanie deskryptora, v0 dalej potrzebne do kolejnych wywolan systemowych
bltz $v0, fileException # ujemna wartosc v0 oznacza blad otwierania pliku

# 2 bajty pierwsze w naglowku - identyfikator pliku ?
move $a0, $t9
la $a1, header
li $a2, 2
li $v0, 14
syscall

# 4 bajty na rozmiar
move $a0, $t9
la $a1, fileSize
li $a2, 4
li $v0, 14
syscall

# zapisanie rozmiaru plliku
lw $s0, fileSize

# wczytanie 4 zaarezerwowanych bajtow
move $a0, $t9
li $v0, 14
la $a1, header
li $a2, 4
syscall

# wczytanie 4 bajtowego offsetu
move $a0, $t9
la $a1, offset
li $a2, 4
li $v0, 14
syscall

# zapisanie offsetu
lw $s1, offset

# 4 bajty naglowka informacyjnego na temat jego wielkosci, interesuje nas i tak tylko kolejne po nim 8 bitow wiec nie potrzebujemy wartosci naglowka
move $a0, $t9
la $a1, header
li $a2, 4
li $v0, 14
syscall

# wczytanie 4 bajtowej informacji o szerokosci obrazka
move $a0, $t9
la $a1, width
li $a2, 4
li $v0, 14
syscall

# zapisanie szerokosci
lw $s2, width

# wczytanie 4 bajtowej informacji o wysokosci obrazka
move $a0, $t9
la $a1, height
li $a2, 4
li $v0, 14
syscall

# zapisanie wysokosci
lw $s3, height

######################################################################################################


#program
j happy_end

######################################################################################################
fileException:
# komunikat b³êdu przy otwieraniu pliku
la $a0, message_1
li $v0, 4
syscall
j exit
######################################################################################################

happy_end:
# komunikat poprawnego wykonego przebiegu zadania
la $a0, message_2
li $v0, 4
syscall
j exit

######################################################################################################

exit:
li $v0, 10
syscall
