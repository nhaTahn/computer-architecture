.data
    inputa: .asciiz "Please input a: "
    inputb: .asciiz "Please input b: "
    inputc: .asciiz "Please input c: "
    inputd: .asciiz "Please input d: "
    result: .asciiz "g = (a + b) * 3 - (c + d) * 2 = "
    
.text
    li $v0, 4           # Prompt input a
    la $a0, inputa      #
    syscall             #
    li $v0, 5           # v0 = a
    syscall             #
    move $s0, $v0       # s0 = a
    
    li $v0, 4           # Prompt input b
    la $a0, inputb     #
    syscall             #
    li $v0, 5           # v0 = b
    syscall             #
    move $s1, $v0
    
    li $v0, 4           # Prompt input a
    la $a0, inputc      #
    syscall             #
    li $v0, 5           # v0 = a
    syscall             #
    move $s2, $v0       # s0 = a
    
    li $v0, 4           # Prompt input a
    la $a0, inputd      #
    syscall             #
    li $v0, 5           # v0 = a
    syscall             #
    move $s3, $v0       # s0 = a
    
    add $t1, $s0, $s1
    mul $t1, $t1, 3
    add $t2, $s2, $s3
    mul $t2, $t2, 2
    sub $t0, $t1, $t2
    
    li $v0, 4           # Print result label
    la $a0, result      #
    syscall             #
 
    li $t0 1            # Print a0
    syscall             #