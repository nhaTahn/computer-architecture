.data
	p: .word 0
	input_size: .asciiz "\n Input the size: \n"
	val_0: .asciiz "Initialize array with value 0 \n"
	input_value: .asciiz "\n Input the value \n"
	after_read: .asciiz "\n The array after read step \n"
	space: .asciiz " "
.text
	li $v0, 4
	la $a0, input_size 
	syscall 
	
	li $v0, 5
	syscall 
	move $t1, $v0
	
	sll $s0, $t1, 2

	
	li $v0, 9 
	move $a0, $s0
	syscall
	
	
	li $v0, 4
	la $a0, val_0
	syscall

	
	jal def_init
	jal def_print
	
	li $v0,4
	la $a0, after_read
	syscall
	
	jal def_read
	
	li $v0,4
	la $a0, after_read
	syscall
	
	jal def_print
	
	li $v0, 10
	syscall
	
	
def_init:

	la $t0, p 
	add $t1,$t0,$s0 
	
initialize: 
	sw $zero, 0($t0) 
	addi $t0, $t0, 4
	slt $t3, $t0, $t1
	bne $t3, $zero, initialize
	jr $ra


def_read:
	la $t0, p
	add $t1, $t0, $s0
	
read_array: 
	li $v0, 5
	syscall
	move $t2, $v0
	
	sw $t2, 0($t0)
	addi $t0, $t0, 4
	slt $t3, $t0, $t1
	bne $t3, $zero, read_array
	jr $ra

def_print:
	la $t0, p
	add $t1, $t0, $s0 
	
print_array:	
	li $v0, 1
	lw $a0, 0($t0)
	syscall
	
	li $v0, 4
	la $a0, space
	syscall
	
	addi $t0, $t0, 4
	slt $t3, $t0, $t1
	bne $t3, $zero, print_array
	
	jr $ra	
