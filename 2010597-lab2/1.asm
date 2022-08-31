.data
	mess: .asciiz "Input radius: "
	mess_res: .asciiz "circle perimeter = "
	d: .float 6.28
.text
	li $v0, 4
	la $a0, mess
	syscall
	
	li $v0, 6
	syscall
	
	lwc1 $f1, d
	mul.s $f12, $f0, $f1
	
	li $v0,4
	la $a0, mess_res
	syscall
	li $v0,2
	syscall
	li $v0, 10
	syscall
	

    