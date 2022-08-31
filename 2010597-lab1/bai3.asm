.data
    mess: .asciiz  "result sum 1->10 = "
    array: .word 1,2,3,4,5,6,7,8,9,10
.text 
main:
    li $v0, 0 #i = 0
    li $t4, 10
    la $s1, array
    li $t0, 0
FOR_LOOP:
    bge $s0, $t4, END_FOR
    lw $t1, ($s1) 
    add $t0, $t0, $t1
    addi $s1, $s1, 4
    addi $s0, $s0, 1
    j FOR_LOOP
END_FOR:
	addi $s0, $s0, -1
	addi $s1, $s1, -4
PRINT:
	li $v0, 4
	la $a0, mess
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
END: li $v0, 10
	syscall