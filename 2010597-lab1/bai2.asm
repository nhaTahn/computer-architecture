.data 
	messa: .asciiz "Give value a = "
	messb: .asciiz "Give value b = "
	messc: .asciiz "Give value c = "
	messd: .asciiz "Give value d = "
	result:  .asciiz "g = (a + b) * 3 - (c + d) * 2 = "
.text
main:
	#a
	li $v0, 4
	la $a0, messa
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	#b
	li $v0, 4
	la $a0, messb
	syscall
	li $v0, 5
	syscall
	move $t1, $v0
	#c
	li $v0, 4
	la $a0, messc
	syscall
	li $v0, 5
	syscall
	move $t2, $v0
	#d
	li $v0, 4
	la $a0, messd
	syscall
	li $v0, 5
	syscall
	move $t3, $v0
	#res = $t4
	add $t4, $t0, $t1 # (a+b) = $t4
	mul $t4, $t4, 3 # (a+b)*3
	
	add $t5, $t2, $t3 # (c+d) = $t5
	mul $t5, $t5, 2
	
	sub $t4, $t4, $t5 #res
	
	#print
	li $v0, 4
	la $a0, result
	syscall
	li $v0, 1
	move $a0, $t4
	syscall
	
	li $v0, 10
	syscall
	