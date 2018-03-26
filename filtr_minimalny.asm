.data
# dane
input: .asciiz "example_input.bmp"
output: .asciiz "example_output.bmp"
.align 2 
header: .space 54

# komunikaty 
message_1: .asciiz "blad otwierania pliku"
message_2: .asciiz "poprawnie zakonczono program"

# $s6 deskryptor output
# $s7 deskryptor input

.text
######################################################################################################
openingFile:
# otwieranie pliku "example_input.bmp"
la $a0, input
li $a1, 0
li $a2, 0
li $v0, 13
syscall

move $s7, $v0 # przechowywanie deskryptora, potrzebne do kolejnych wywolan systemowych
bltz $v0, fileException # ujemna wartosc v0 oznacza blad otwierania pliku

# otwieranie pliku "example_output.bmp"
la $a0, output
li $a1, 1
li $a2, 0
li $v0, 13
syscall

move $s6, $v0 # przechowywanie deskryptora, potrzebne do kolejnych wywolan systemowych
bltz $v0, fileException # ujemna wartosc v0 oznacza blad otwierania pliku

# pobranie calego naglowka
move $a0, $s7
la $a1, header
li $a2, 54
li $v0, 14
syscall

# przepisanie naglowka- bedzie taki sam w output jak w input
move $a0, $s6
la $a1, header
li $a2, 54
li $v0, 15
syscall
######################################################################################################


#program
j successful

######################################################################################################
fileException:
# komunikat b³êdu przy otwieraniu pliku
la $a0, message_1
li $v0, 4
syscall
j exit
######################################################################################################
successful:
# komunikat poprawnego wykonego przebiegu zadania
la $a0, message_2
li $v0, 4
syscall
j closeFiles
######################################################################################################
closeFiles:
li $v0, 16
move $a0, $s7
syscall

li $v0, 16
move $a0, $s6
syscall
j exit
######################################################################################################
exit:
li $v0, 10
syscall
