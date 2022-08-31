.data
	mess: .asciiz "Input number a: "
	odd_mess: .asciiz "a is an odd number"
	even_mess: .asciiz "a is an even number"
.text
	li $v0, 4
	la $a0, mess
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	li $t1, 2
	div $t0, $t1
	mfhi $t1
	beq $t1, 0,even
odd: 	li $v0,4 
	la $a0, odd_mess
	syscall
	
	li $v0, 10
	syscall
	
even:	li $v0,4 
	la $a0, even_mess
	syscall
	
	li $v0, 10
	syscall