.data
array:	.word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
size:	.word 10

.text
main:
    	la $a0, array	# $a0: address of array
    	lw $a1, size	# $a1: array size
   
    	jal sum
    
    	add $a0, $v0, $zero
    
    	li $v0, 1
    	syscall
    
    	j end
    # returns $v0: sum of array
sum:
	beq $a1, 1, sum_basecase    
sum_recursive:
    	lw $s0, 0($a0)
    	addi $a0, $a0, 4
    	subi $a1, $a1, 1
    	
    	subi $sp, $sp, 8 #
    	sw $ra, 4($sp)   #
    	sw $s0, 0($sp)   #
    	jal sum          # push and pop stack frame
    	lw $s0, 0($sp)   #
    	lw $ra, 4($sp)   #
    	addi $sp, $sp, 8 #
    
    	add $v0, $v0, $s0    
    	jr $ra
sum_basecase:
	lw $v0, 0($a0)
	jr $ra
end:	
	li $v0,10
    	syscall