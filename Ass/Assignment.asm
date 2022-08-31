.data
	input_a: .asciiz "Enter a: "
	input_b: .asciiz "Enter b: "
	print_res: .asciiz "Result of multiplication: "
	print_overflow: .asciiz "Exponent is overflowed."
	print_underflow: .asciiz "Exponent is underflowed."
.text
	# input a
	la $a0, input_a
	li $v0, 4
	syscall
	li $v0, 6
	syscall
	mfc1 $a1, $f0	# move a to memory address of register $a1
	# input b
	la $a0, input_b
	li $v0, 4
	syscall
	li $v0, 6
	syscall
	mfc1 $a2, $f0	# move b to memory address of register $a2
	
	jal multiply	# call procedure	
print:	
	# print result from register $a3
	la $a0, print_res
	li $v0, 4
	syscall
	
	mtc1 $a3, $f12 # move data in $a3 to register $f12
	li $v0, 2
	syscall
exit:
	li $v0, 10
	syscall
multiply:
	# check if a or b is zero
	beq $a1, $zero, return0
	beq $a1, 0x80000000, return0
	beq $a2, $zero, return0
	beq $a2, 0x80000000, return0
sign:
	srl $t1, $a1, 31	# $t1 = sign_a
	srl $t2, $a2, 31 	# $t2 = sign_b
	
	# $s0 stores sign of result
	xor $s0, $t1, $t2	
exponent:
	srl $t1, $a1, 23
	andi $t2, $t1, 0xFF	# $t2 = exponent_a
	
	srl $t3, $a2, 23
	andi $t4, $t3, 0xFF 	# $t4 = exponent_b
	
	# $s1 stores exponent field of result
	add $s1, $t2, $t4
	addi $s1, $s1, -127	

fraction:
	andi $t1, $a1, 0x007FFFFF 	# t1 = fraction_a
	andi $t2, $a2, 0x007FFFFF 	# t2 = fraction_b
	
	# add implicit '1' bit, now each fraction has 24-bits wide
	ori $t1, $t1, 0x00800000
	ori $t2, $t2, 0x00800000
	# shift left 8 bits for multiplying two fractions
	sll $t1, $t1, 8
	sll $t2, $t2, 8
	
	multu $t1, $t2	
	mfhi $t3	# $t3 stores 32 high-bits of multiplication
	
	# if MSB is bit '1', normalize it (shift left 1 bit and increase exponent by 1)
	srl $t4, $t3, 31	# $t4 is MSB of $t3	
	beq $t4, $zero, end_fraction
	srl $t3, $t3, 1			
	addi $s1, $s1, 1
end_fraction:
	# store fraction to register $s2
	sll $t3, $t3, 2		# as we added '1' bit, shift left 2 to move that '1' bit 
	srl $s2, $t3, 9		# move fraction to the right position
exception:	# no exception if 1 <= exponent <= 254
	bgt $s1, 254, overflow
	blt $s1, 1, underflow	
end_multiply:	
	# move sign and exponent to the right position
	sll $s0, $s0, 31	
	sll $s1, $s1, 23
	
	# store result in register $a3
	add $a3, $s1, $s2
	or $a3, $a3, $s0

	jr $ra	# end procedure
return0:
	move $a3, $zero		# a * b = 0
	j print
overflow:
	la $a0, print_overflow
	li $v0, 4
	syscall
	j exit
underflow:
	la $a0, print_underflow
	li $v0, 4
	syscall
	j exit
	
