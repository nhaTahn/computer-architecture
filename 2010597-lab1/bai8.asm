.data
int_a:	.word	0
input:	.word	13

mess1:	.asciiz	"Input: "
mess2:	.asciiz "Please input an another integer numbers \n"
res_mess: .asciiz "a = "

.text
.globl	main

main:
	la	$a0,mess1
	addi	$v0,$zero,4
	syscall
		
	addi	$v0,$zero,5
	syscall	
	sw	$v0,input

	lw 	$t0,int_a
	lw 	$t1,input
	addi 	$t2,$zero,0
	addi 	$t3,$zero,0
	add 	$t2,$t2,10
	add 	$t3,$t3, 5
#xet case
case:
  	beq $t1, 0, case1
  	beq $t1, 1, case2
  	beq $t1, 2, case3
 	j default
case1:	add	$t0,$t2,$t3
	j	endswitch
case2:	sub	$t0,$t2,$t3
	j	endswitch
case3:	sub	$t0,$t3,$t2
	j	endswitch
default:
	la $a0, mess2
	addi	$v0,$zero,4
	syscall	
	j end
endswitch:	sw	$t0,int_a

print:	la	$a0,res_mess
	addi	$v0,$zero,4
	syscall	
	lw	$a0,int_a
	addi	$v0,$zero,1
	syscall
end:
	addiu	$v0,$zero,10
	syscall
