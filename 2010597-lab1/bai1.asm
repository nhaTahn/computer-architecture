.data 
mess : .asciiz "Enter value: "

.text
main:
	li $v0, 4
	la $a0, mess
	syscall
	
	li $v0, 5
	syscall
	
	move $t0, $v0
	add $t0, $t0, 1
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 10
	syscall
	
	
