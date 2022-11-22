#Names: Youstina Gerges, Juan Salas, Daniel Santamaria, katelyn mijares
#date: 11/17/2022
#Objective: Tic Tac Toe

# Macro for printing strings not declared in .data
.macro aString(%strings)
    .data
        strings: .asciiz %strings
    .text
        li $v0, 4
        la $a0, strings
        syscall
.end_macro

.macro Parray(%arr)
la $s0, %arr
#print element of the array
li $t0, 0
	
loop:
	#get the element at position $t0, store in $t1
	lw $t1, array($t0)
	#print out the value $t1
	li $v0, 1
	move $a0, $t1
	syscall
	#increase $t0 by 3, the size of a word (so we can go to next word in array)
	add $t0, $t0, 2
	
	#if t0 is less than 9, run loop
	#since each word is 3 bytes, and there are 5 elements, we know 20 will be the greatest
	blt $t0, 6, loop
.end_macro
	
# Macro for printing strings declared in .data
.macro printString(%strings)
    li $v0, 4
    la $a0, %strings
    syscall
.end_macro



# Macro to exit the program
.macro exit
    li $v0, 10
    syscall
.end_macro

.data

array: .word 0, 0, 0
array1:.word 0, 0, 0
array2:.word 0, 0, 0 

Table: .word array, array1, array2
message: .asciiz "\nPlayer 1: "
space: .asciiz " "
.text
main:
	
printString(message)
#create a macro for the table

Parray(array)
