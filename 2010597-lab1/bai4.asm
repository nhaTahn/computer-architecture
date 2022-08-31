.data
	array: .word 0,1,2,3,4,5,6,7,8,9
	mess: .asciiz "Input a number x (0 < x < 10): "
.text
	li $v0,4
	la $a0,mess
	syscall
	
	li $v0,5
	syscall
	
	move $t0,$v0
	mul $t0,$t0, 4
	
	la $s0,array
	add $s0,$s0,$t0
	lw $a0,0($s0)
	li $v0,1
	syscall
	
	
	
