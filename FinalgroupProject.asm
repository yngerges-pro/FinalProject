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

.macro pName(%strings)
	
		li $v0, 4
		la $a0, (%strings)
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
	# Load current player 
	li $s7, %player
	
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
	pString("\nInvalid input please try again. \n")
	printBoard
	j input
taken:
	pString("\nThis spot is already taken. \n")
	printBoard
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
	
	j checkTie
	
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
		beq $t3, 0, checkTie
		beq $t3, $t5, win
		j checkTie
		
	checkTie:
		z0:bnez $t0, z1
		j %label
		z1:bnez $t1, z2
		j %label
		z2:bnez $t2, z3
		j %label
		z3:bnez $t3, z4
		j %label
		z4:bnez $t4, z5
		j %label
		z5:bnez $t5, z6
		j %label
		z6:bnez $t6, z7
		j %label
		z7:bnez $t7, z8
		j %label
		z8:bnez $t8, tie
		j %label

.end_macro

# reset the board
.macro resetBoard
	li $t1, 0
	
	la $t0, row1	
	sw $t1, 0($t0)
	sw $t1, 4($t0)
	sw $t1, 8($t0)
	
	la $t0, row2
	sw $t1, 0($t0)
	sw $t1, 4($t0)
	sw $t1, 8($t0)
	
	la $t0, row3
	sw $t1, 0($t0)
	sw $t1, 4($t0)
	sw $t1, 8($t0)
.end_macro

.data

	row1: .word 0, 0, 0
	row2:.word 0, 0, 0
	row3:.word 0, 0, 0 

	Table: .word row1, row2, row3
	
	p1buffer: .space 300
	p2buffer: .space 300
.text
# start of the program
main:
	pString("\n\n------TIC TAC TOE------\n")
	
	pString("\nr: Read the Rules \n")
	pString("p: Play (2 players) \n")
	pString("e: Exit the Game \n")
	
	pString("Enter your choice: ")
	
	li $v0, 12
	syscall	
	move $s4, $v0
	
	pString("\n")
	
	beq $s4, 'r', rules
	beq $s4, 'p', gameStart
	beq $s4, 'e', exit

	j invalidChoice

invalidChoice:
	pString("\ninvalid input please try again. \n")
	j main

rules:
	pString("\n-RULES FOR TIC TAC TOE-\n")
	pString("1. The game is played on a grid that's 3 squares by 3 grid (of dots).\n")
	pString("2. Player 1 is X, Player 2 is O. Players take turns putting their marks in empty spots.\n")
	pString("3. The first player to get 3 of their marks in a row (up, down, across, or diagonally) is the winner.\n")
	pString("4. When all 9 squares are full, the game is over. If no player has 3 marks in a row, the game ends in a tie.\n")
	
	pString("\nEnter any key to exit ")
	li $v0, 12
	syscall
	
	j main

gameStart:	
	pString("\nPlayer One enter a name: ")
	
	li $v0, 8
	la $a0, p1buffer
	li $a1, 300
	syscall
	move $s5, $a0
	
	# Removed newline from player name to make printing better
	removeNewLine:
    		lbu $a3, p1buffer($a2)  
   		addi $a2, $a2, 1
    		bnez $a3, removeNewLine
    		beq $a1, $a2, skip
    		subi $a2, $a2, 2
    		sb $0, p1buffer($a2)
	skip:
	# Reset arguements
	la $a2, 0
	la $a3, 0
	pString("Player 2 Enter a name:: ")
	
	li $v0, 8
	la $a0, p2buffer
	li $a1, 300
	syscall
	move $s6, $a0
	
	# Removed newline from player name to make printing better
	removeNewLine2:
    		lbu $a3, p2buffer($a2)  
   		addi $a2, $a2, 1
    		bnez $a3, removeNewLine2
    		beq $a1, $a2, skip
    		subi $a2, $a2, 2
    		sb $0, p2buffer($a2)
	skip2:
		
	printBoard
	
player1:
	pString("\n")
	pName($s5)
	pString("'s Turn (X) \n")
	playerInput(1, player2)	
player2:
	pString("\n")
	pName($s6)
	pString("'s Turn (O)\n")
	playerInput(2, player1)
	
win:
	# Win msg based on current player
	beq $s7, 2, win2
	pString("\n")
	pName($s5)
	pString(" Wins!\n")
	j playagain
win2:
	pString("\n")
	pName($s6)
	pString(" Wins!\n")
	j playagain
tie:
	pString("\nIT'S A TIE\n")
	j playagain
	
playagain:
	resetBoard
	pString("play again? (Y or N) ")
	
	li $v0, 12
	syscall	
	move $s4, $v0
	
	pString("\n")
	
	beq $s4, 'Y', gameStart
	beq $s4, 'y', gameStart
	beq $s4, 'N', main
	beq $s4, 'n', main	
	
	pString("invalid input please try again.\n")
	j playagain

exit: exit
