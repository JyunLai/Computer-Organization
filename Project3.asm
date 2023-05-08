.data 
	string1:.asciiz "Please input the number of Gray code bits:\n\0"
	string2:.asciiz "Gray code list:\n\0"
	illegal:.asciiz "Illegal!!!\n\0"
	newline:.asciiz "\n\0"
	here:.asciiz "here\0"
	there:.asciiz "there\0"
.text
main:
	la $a0,string1
	li $v0,4
	syscall
	li $v0,5
	syscall
	la $a1,($v0)
	li $v1,1
	li $a0,2
	li $t1,0
	sle $t1,$v0,0
	li $t2,16
	sle $t1,$t2,$v0
	beqz $t1,loop
	la $a0,illegal
	li $v0,4
	syscall
	j end
loop:
	la $a0,string2
	li $v0,4
	syscall
loop1:
	mul $v1,$v1,2
	addi $a1,$a1,-1
	bnez $a1,loop1
	la $a1,($v0)
	li $a2,0
numstart:
	la $a3,($v1)
	la $s4,($a2)
	li $a0,2
	div $a3,$a0
	mflo $a3
	sle $s0,$a3,$s4
	beqz $s0,printzero
	li $s2,1
	mul $s5,$a3,-1
	add $s4,$s4,$s5
	li $a0,1
	li $v0,1
	syscall
	beq $a3,1,endthisnum
	j loop2
	printzero:
	li $s2,0
	li $a0,0
	li $v0,1
	syscall
	beq $a3,1,endthisnum
loop2:
	la $s1,($s2)
	li $a0,2
	div $a3,$a0
	mflo $a3
	sle $s0,$a3,$s4
	beqz $s0,zero
	li $s2,1
	mul $s5,$a3,-1
	add $s4,$s4,$s5
	j cont
	zero:
	li $s2,0
	cont:
	beq $s1,$s2,equal
	j notequal
equal:
	li $a0,0
	li $v0,1
	syscall
	beq $a3,1,endthisnum
	j loop2
notequal:
	li $a0,1
	li $v0,1
	syscall
	beq $a3,1,endthisnum
	j loop2
endthisnum:
	la $a0,newline
	li $v0,4
	syscall
	addi $a2,$a2,1
	bne $a2,$v1,numstart
end: