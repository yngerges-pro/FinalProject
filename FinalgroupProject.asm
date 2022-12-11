#Names: Youstina Gerges, Juan Salas, Daniel Santamaria, katelyn mijares
#date: 11/17/2022
#Objective: Tic Tac Toe

# Macro for printing strings not declared in .data
.macro pString(%strings)
    	.data
		strings: .asciiz %strings
	.text
		li $v0, 4
        	la $a0, strings
        	syscall
.end_macro

# Macro to exit the program
.macro exit
	li $v0, 10
	syscall
.end_macro

# Macro printing out each row of the board
.macro pRow(%arr)
	la $s0, %arr
	li $t0, 0
	# prints X or O based on which player if any occupies a spot
	loop:
		lw $s0, %arr($t0)
		
		beq $s0, 1, printX
		beq $s0, 2, printO
							
		pString(".")
		pString("  ")
		addi $t0, $t0, 4
		
		blt $t0, 10, loop
		bgt $t0, 9, printfinish
		
	printX:					
		pString("X")
		pString("  ")
		addi $t0, $t0, 4
		
		blt $t0, 10, loop
		bgt $t0, 9, printfinish
	printO:					
		pString("O")
		pString("  ")
		addi $t0, $t0, 4
		
		blt $t0, 10, loop
	printfinish:
.end_macro

# Macro responsible for printing the layout of the board.
.macro printBoard
	pString("   c1 c2 c3\n")
	pString("r1 ")
	pRow(row1)
	pString("\n")
	pString("r2 ")
	pRow(row2)
	pString("\n")
	pString("r3 ")
	pRow(row3)
	pString("\n")
	
.end_macro

# prints 1 or 2 depending on the player
.macro playerInput(%player, %label)
	
input:

	pString("\nEnter a row ")
	li $v0, 5
	syscall	
	move $s0, $v0
	
	bgt $s0, 3, invalid
	
	pString("\nEnter a column ")
	li $v0, 5
	syscall	
	move $s1, $v0
	
	bgt $s1, 3, invalid
	
	# branch based on row choice
	beq $s0, 1, r1
	beq $s0, 2, r2
	beq $s0, 3, r3
	
invalid:
	pString("\ninvlaid input please try again. \n")
	j input
taken:
	pString("\nthis spot is already taken. \n")
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
	# load values of each spot into registers
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

    #Checks for each possible 3 in a row
	
	top1: beq $t0, $t1, top2
	left1: beq $t0, $t3, left2
	bottom1: beq $t6, $t7, bottom2
	right1: beq $t2, $t5, right2
	backslash1: beq $t0, $t4, backslash2
	forwardslash1: beq $t6, $t4, forwardslash2
	midvert: beq $t1, $t4, midvert2
	midhoriz: beq $t3, $t4, midhoriz2
	
	j %label
	
	top2:
		beq $t0, 0, left1
		beq $t0, $t2, win
		j left1
	left2:
		beq $t0, 0, bottom1
		beq $t0, $t6, win		
		j bottom1
	bottom2:
		beq $t6, 0, right1
		beq $t6, $t8, win
		j right1
	right2:
		beq $t2, 0, backslash1
		beq $t2, $t8, win
		j backslash1
	backslash2:
		beq $t0, 0, forwardslash1
		beq $t0, $t8, win
		j forwardslash1
	forwardslash2:
		beq $t6, 0, midvert
		beq $t6, $t2, win
		j midvert
	midvert2:
		beq $t1, 0, midhoriz
		beq $t1, $t7, win
		j midhoriz
	midhoriz2:
		beq $t3, 0, %label
		beq $t3, $t5, win
		j %label

.end_macro

.data

	row1: .word 0, 0, 0
	row2:.word 0, 0, 0
	row3:.word 0, 0, 0 

	Table: .word row1, row2, row3
.text
# start of the program
main:
	pString("\nTIC TAC TOE \n")
	pString("PLAYER ONE'S TURN \n")
	printBoard
	
player1:
	pString("\nPLAYER ONE'S TURN \n")
	playerInput(1, player2)	
player2:
	pString("\nPLAYER TWO'S TURN \n")
	playerInput(2, player1)
	
win:
	pString("\nGAME END\n")

exit: exit
