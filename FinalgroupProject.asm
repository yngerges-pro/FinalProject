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
	
input:

	aString("\nEnter a row ")
	li $v0, 5
	syscall	
	move $s0, $v0
	
	bgt $s0, 3, invalid
	
	aString("\nEnter a column ")
	li $v0, 5
	syscall	
	move $s1, $v0
	
	bgt $s1, 3, invalid
	
	# branch based on row choice
	beq $s0, 1, r1
	beq $s0, 2, r2
	beq $s0, 3, r3
	
invalid:
	aString("\ninvlaid input please try again. \n")
	j input
taken:
	aString("\nthis spot is already taken. \n")
	j input
	
# branch based on row and column choice
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
	
	# Check if spot has been taken	
	lw $t2, 0($t0) 
	
	beq $t2, 1, taken
	beq $t2, 2, taken
	
	sw $t1, 0($t0)
	
	printBoard
	checkBoard(%label)
	
	
row1col2:
	la $t0, row1
	li $t1, %player
	
	# Check if spot has been taken	
	lw $t2, 4($t0) 
	
	beq $t2, 1, taken
	beq $t2, 2, taken
	
	sw $t1, 4($t0)
	
	printBoard
	checkBoard(%label)	
		
row1col3:
	la $t0, row1
	li $t1, %player
	
	# Check if spot has been taken	
	lw $t2, 8($t0) 
	
	beq $t2, 1, taken
	beq $t2, 2, taken
	
	sw $t1, 8($t0)
	
	printBoard
	checkBoard(%label)
row2col1:
	la $t0, row2
	li $t1, %player
	
	# Check if spot has been taken	
	lw $t2, 0($t0) 
	
	beq $t2, 1, taken
	beq $t2, 2, taken
	
	sw $t1, 0($t0)
	
	printBoard
	checkBoard(%label)
row2col2:
	la $t0, row2
	li $t1, %player
	
	# Check if spot has been taken	
	lw $t2, 4($t0) 
	
	beq $t2, 1, taken
	beq $t2, 2, taken
	
	sw $t1, 4($t0)
	
	printBoard
	checkBoard(%label)
row2col3:
	la $t0, row2
	li $t1, %player
	
	# Check if spot has been taken	
	lw $t2, 8($t0) 
	
	beq $t2, 1, taken
	beq $t2, 2, taken
	
	sw $t1, 8($t0)
	
	printBoard
	checkBoard(%label)
row3col1:
	la $t0, row3
	li $t1, %player
	
	# Check if spot has been taken	
	lw $t2, 0($t0) 
	
	beq $t2, 1, taken
	beq $t2, 2, taken
	
	sw $t1, 0($t0)
	
	printBoard
	checkBoard(%label)
row3col2:
	la $t0, row3
	li $t1, %player
	
	# Check if spot has been taken
	lw $t2, 4($t0) 
	
	beq $t2, 1, taken
	beq $t2, 2, taken
	sw $t1, 4($t0)
	
	printBoard
	checkBoard(%label)
row3col3:
	la $t0, row3
	li $t1, %player
	
	# Check if spot has been taken
	lw $t2, 8($t0) 
	
	beq $t2, 1, taken
	beq $t2, 2, taken
	
	sw $t1, 8($t0)
	
	printBoard
	checkBoard(%label)

.end_macro

.macro checkBoard(%label)
	
	la $s0, row1
	la $s1, row2
	la $s2, row3
	
	lw $t0, 0($s0)
	lw $t1, 4($s0)
	lw $t2, 8($s0)	
	
	lw $t3, 0($s1)
	lw $t4, 4($s1)
	lw $t5, 8($s1)

	lw $t6, 0($s2)
	lw $t7, 4($s2)
	lw $t8, 8($s2)
	
	to: beq $t0, $t1, top
	le: beq $t0, $t3, left
	bo: beq $t6, $t7, bottom
	ri: beq $t2, $t5, right
	ba: beq $t0, $t4, backslash
	fo: beq $t6, $t4, forwardslash
	
	j %label
	
	top:
		beq $t0, 0, le
		beq $t0, $t2, win
		beq $t0, $t3, left
		beq $t6, $t7, bottom
		beq $t2, $t5, right
		beq $t0, $t4, backslash
		beq $t6, $t4, forwardslash
		j %label
	left:
		beq $t0, 0, bo
		beq $t0, $t6, win
		beq $t6, $t7, bottom
		beq $t2, $t5, right
		beq $t0, $t4, backslash
		beq $t6, $t4, forwardslash		
		j %label
	bottom:
		beq $t6, 0, ri
		beq $t6, $t8, win
		beq $t2, $t5, right
		beq $t0, $t4, backslash
		beq $t6, $t4, forwardslash
		j %label
	right:
		beq $t2, 0, ba
		beq $t2, $t8, win
		beq $t0, $t4, backslash
		beq $t6, $t4, forwardslash
		j %label
	backslash:
		beq $t0, 0, fo
		beq $t0, $t8, win
		beq $t6, $t4, forwardslash
		j %label
	forwardslash:
		beq $t6, 0, %label
		beq $t6, $t2, win
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
# start of the program
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
	
win:
	aString("\nGAME END\n")

exit: exit
