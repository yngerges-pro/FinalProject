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

# Macro for printing array given name
.macro Parray(%arr)
	la $s0, %arr
	#print element of the array
	li $t0, 0
	
	loop:
		#get the element at position $t0, store in $t1
		lw $s0, %arr($t0)
		#print out the value $t1
		li $v0, 1
		move $a0, $s0
		syscall
		
		aString("  ")
		#increase $t0 by 3, the size of a word (so we can go to next word in array)
		addi $t0, $t0, 4
		
		#if t0 is less than 9, run loop
		#since each word is 3 bytes, and there are 5 elements, we know 20 will be the greatest
		blt $t0, 10, loop
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

# Macro for printing strings declared in .data
.macro printBoard
	aString("   c1 c2 c3\n")
	
	aString("r1 ")
	Parray(row1)
	aString("\n")
	aString("r2 ")
	Parray(row2)
	aString("\n")
	aString("r3 ")
	Parray(row3)
	aString("\n")
	
.end_macro

# prints 1 or 2 depending on the player
.macro playerInput(%player, %label)
	aString("\nEnter a row ")
	li $v0, 5
	syscall	
	move $s0, $v0
	
	aString("\nEnter a column ")
	li $v0, 5
	syscall	
	move $s1, $v0
	
	beq $s0, 1, r1
	beq $s0, 2, r2
	beq $s0, 3, r3
	
	
r1:
	beq $s1, 1, row1col1
	beq $s1, 2, row1col2
	beq $s1, 3, row1col3

r2:
	beq $s1, 1, row2col1
	beq $s1, 2, row2col2
	beq $s1, 3, row2col3
	
r3:
	beq $s1, 1, row3col1
	beq $s1, 2, row3col2
	beq $s1, 3, row3col3	

row1col1:
	la $t0, row1
	li $t1, %player
	sw $t1, 0($t0)
	
	printBoard
	j %label
	
	
row1col2:
	la $t0, row1
	li $t1, %player
	sw $t1, 4($t0)
	
	printBoard
	j %label	
		
row1col3:
	la $t0, row1
	li $t1, %player
	sw $t1, 8($t0)
	
	printBoard
	j %label
row2col1:
	la $t0, row2
	li $t1, %player
	sw $t1, 0($t0)
	
	printBoard
	j %label
row2col2:
	la $t0, row2
	li $t1, %player
	sw $t1, 4($t0)
	
	printBoard
	j %label
row2col3:
	la $t0, row2
	li $t1, %player
	sw $t1, 8($t0)
	
	printBoard
	j %label
row3col1:
	la $t0, row3
	li $t1, %player
	sw $t1, 0($t0)
	
	printBoard
	j %label
row3col2:
	la $t0, row3
	li $t1, %player
	sw $t1, 4($t0)
	
	printBoard
	j %label
row3col3:
	la $t0, row3
	li $t1, %player
	sw $t1, 8($t0)
	
	printBoard
	j %label

.end_macro

.data

	row1: .word 0, 0, 0
	row2:.word 0, 0, 0
	row3:.word 0, 0, 0 

	Table: .word row1, row2, row3
	message: .asciiz "\nPlayer 1's Turn \n"
	space: .asciiz " "
.text

main:
	aString("\nTIC TAC TOE \n")
	aString("PLAYER ONE'S TURN \n")
	printBoard
	
player1:
	aString("\nPLAYER ONE'S TURN \n")
	playerInput(1, player2)	
player2:
	aString("\nPLAYER TWO'S TURN \n")
	playerInput(2, player1)


exit: exit
