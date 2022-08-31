.data
	array: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
	print: .asciiz "Print array: "
	r_print: .asciiz "\nAfter reversing: "
	space: .asciiz " "
.text
	la $a0, print
	li $v0, 4
	syscall
	
	la $a1, array
	jal printarr
	
	la $a0, r_print
	li $v0, 4
	syscall
	
	jal r_loop
	jal printarr
	
	li $v0, 10
	syscall
	
printarr:
	addi $t0, $0, 0
    ploop:
	beq $t0, 10, end
	sll $t1, $t0, 2
	add $t2, $t1, $a1
	
	lw $t3, ($t2)
	move $a0, $t3
	li $v0, 1
	syscall
	
	la $a0, space
	li $v0, 4
	syscall
	
	addi $t0, $t0, 1
	j ploop
	
end:    jr $ra
	
r_loop:
	addi $t0, $0, 0
    rloop:
    	beq $t0, 5, r_end
	sll $t1, $t0, 2
	add $t2, $t1, $a1
	lw $t8, ($t2)
	
	addi $t3, $0, 36
	sub $t3, $t3, $t1
	add $t4, $t3, $a1
	lw $t9, ($t4)
	
	sw $t8, ($t4)
	sw $t9, ($t2)
	
	addi $t0, $t0, 1
	j rloop
	
r_end:  jr $ra
