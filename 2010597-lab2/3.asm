.data
array:	.asciiz "Computer Architecture 2021"
size:	.word 26
.text
main:
    la $a0, array 	# $a0: address of string
    lw $a1, size  	# $a1: size of string
    
    jal reverse
    
    li $v0, 4
    syscall
    
    j end

reverse:
    add $t0, $a0, $zero
    add $t1, $a0, $a1
    subi $t1, $t1, 1
reverse_loop:
    slt $t2, $t0, $t1
    beqz $t2, reverse_loop_end # terminate loop
    
    lb $t3, 0($t0)
    lb $t4, 0($t1)
    sb $t4, 0($t0)
    sb $t3, 0($t1)
    
    addi $t0, $t0, 1  # left = left + 1
    subi $t1, $t1, 1  # right = right - 1
    
    j reverse_loop                 # loop back up
reverse_loop_end:
    jr $ra
end:
