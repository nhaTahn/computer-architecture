.data
char:	.byte	't'
str_s:	.asciiz	"Kien truc may tinh"
int_t:	.word	0

res_mess: .asciiz  "Index of the first 't' in string 'Kien truc may tinh': "

.text
.globl	main 
main: 
	lb 	$t1,char
	la	$t2,str_s
	lb 	$t3,0($t2)	
	addi	$t0,$zero,0 #index = 0
while:
	beq	$t3,$t1, end_while
	addi	$t0,$t0,1
	la 	$t2,1($t2)
	lb 	$t3,0($t2)
	j	while
end_while:
	sw	$t0,int_t	 

print:	la	$a0,res_mess
	addi	$v0,$zero,4
	syscall	
	lw	$a0,int_t
	addi	$v0,$zero,1
	syscall

end:
	addiu	$v0,$zero,10
	syscall
