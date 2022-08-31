.data
    arr: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
    size: .word 40
.text
    la $a0, arr
    lw $a1, size
    
    jal range
    
    move $a0,$v0
	li $v0,1
	syscall
	
    j end

range:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    jal def_min
    addi $s0, $v0, 0
    jal def_max
    addi $s1, $v0, 0
    sub $v0, $s1, $s0
    
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

def_min:
    addi $t0, $zero, -4       
    lw $v0, 0($a0)
    
min_loop:
    addi $t0, $t0, 4        
    beq $t0, $a1, min_end    
    add $t1, $a0, $t0        
    lw $t1, 0($t1)         
    slt $t2, $t1, $v0        
    beq $t2, $zero, min_loop   
    add $v0, $t1, $zero       
    j min_loop      
              
min_end:
    jr $ra
    
def_max:
    addi $t0, $zero, -4        
    lw $v0, 0($a0)
    
max_loop:
    addi $t0, $t0, 4           
    beq $t0, $a1, max_end    
    add $t1, $a0, $t0         
    lw $t1, 0($t1)         
    slt $t2, $v0, $t1      
    beq $t2, $zero, max_loop  
    add $v0, $t1, $zero     
    j max_loop   
                  
max_end:
    jr $ra
    
end: