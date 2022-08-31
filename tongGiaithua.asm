.data
out_string: .asciiz "\nNhap so!\n"

.text
main: 
li $v0, 4
la $a0, out_string
syscall
# input so nguyen N
li $v0, 5
syscall
add $t1, $v0,$zero # t1 = v0 + 0 --> N <-> t1

# call procedure
jal tinhtoan
#jal GiaiThua

# PRINT PROCEDURE RESULT
# IN SO SUM RA MAN HINH
printResult:	
	add $a0, $v1, $zero # a0 = sum + 0
	li $v0,1
	syscall
# EXIT
j Exit

# START PROCEDURE TINHTOAN
tinhtoan:
	addi $sp, $sp, -8
	sw $ra, 0($sp)
	sw $t1, 4($sp)
	
	blt $t1, 1, END
	j ELSE	
END:
	li $v1, 1
	lw $ra, 0($sp)
lw $t1, 4($sp)
	addi $sp, $sp, 8
	jr $ra
ELSE:	
	addi $t1,$t1, -1
	add $t2, $t1, $zero # $t2 --> tham so GiaiThua
	jal GiaiThua	# --> result ->$v0				
	jal tinhtoan

		
	lw $ra, 0($sp)	
	lw $t1, 4($sp) # load n
	# calculate GiaiThua(n) --> $v0
	addi $sp, $sp, 8	
	mul $v0, $v0, $t1	
	add $v1, $v1, $v0  # Sum(n-1)+ GiaiThua(n)
	jr $ra	
# Exit chuong trinh

GiaiThua:
 	addi $sp, $sp, -8
 	sw $ra, 0($sp)
 	sw $t2, 4($sp)
 	
 	blt $t2, 1, END_GT
 	j ELSE_GT
 END_GT:
 	li $v0, 1
 	
 	lw $ra, 0($sp)
 	
lw $t2, 4($sp)
 	addi $sp, $sp, 8
 	jr $ra 
 ELSE_GT:
	addi $t2, $t2, -1
	jal GiaiThua # get GiaiThua(n-1)
	
	lw $ra, 0($sp)
 	lw $t2, 4($sp) # (restore n)
 	addi $sp, $sp, 8
 	
 	mul $v0, $v0, $t2 # GiaiThua(n-1) * n
 	jr $ra
Exit:
li $v0, 10
syscall