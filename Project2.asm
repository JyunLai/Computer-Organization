.data 
	string1:.asciiz "Please input a postfix arithmetic expression:\n\0"
	string2:.asciiz "The value is: \0"
	string3:.asciiz "This is an illegal postfix arithmetic expression.\n\0"
	enter:.asciiz "\n\0"
	p:.asciiz "plus\0"
.text
main:
	li $t9,0
	li $v0,4
	la $a0,string1
	syscall
	li $v0,8
	li $a1,100
	syscall
	la $t0,($a0)
	la $t5,($a0)
	li $s0,0
loop:
	li $s7,0
	lb $s1,($t0)
	li $v0,47
	li $t7,58
	li $s5,44
	beq $s1,$s5,exit
	li $s5,46
	beq $s1,$s5,period
	li $s5,43
	beq $s1,$s5,plus
	li $s5,45
	beq $s1,$s5,minus
	li $s5,42
	beq $s1,$s5,multi
	li $s5,47
	beq $s1,$s5,divide
	slt $t1,$v0,$s1
	slt $t2,$s1,$t7
	beqz $t1,exit
	beqz $t2,exit
	addi $s0,$s0,1
	addi $t0,$t0,1
	j loop
negative:
	addi $s0,$s0,1
	addi $t0,$t0,1
	j loop
period:
	li $a1,0
	li $s1,1
	la $s2,($s0)
	la $t1,($t5)
	addi $t0,$t0,1
	beqz $s2,success
endloop2:
	beq $s2,1,endloop1
	mul $s1,$s1,10
	addi $s2,$s2,-1
	j endloop2
endloop1:
	beqz $s0,endgoloop
	addi $s0,$s0,-1
	lb $s2,($t1)
	li $s5,45
	beq $s2,$s5,endnegative1
	addi $s2,$s2,-48
	mul $a2,$s2,$s1
	add $a1,$a1,$a2
	li $s5,10
	div $s1,$s5
	mflo $s1
	addi $t1,$t1,1
	j endloop1
endgoloop:
	addi $sp,$sp,-4
	sw $a1,0($sp)
	li $s0,0
	la $t5,($t0)
	addi $t9,$t9,1
	j success
exit:
	li $a1,0
	li $s1,1
	la $s2,($s0)
	la $t1,($t5)
	addi $t0,$t0,1
	beqz $s2,loop
loop2:
	beq $s2,1,loop1
	mul $s1,$s1,10
	addi $s2,$s2,-1
	j loop2
loop1:
	beqz $s0,goloop
	addi $s0,$s0,-1
	lb $s2,($t1)
	li $s5,45
	beq $s2,$s5,negative1
	addi $s2,$s2,-48
	mul $a2,$s2,$s1
	add $a1,$a1,$a2
	li $s5,10
	div $s1,$s5
	mflo $s1
	addi $t1,$t1,1
	j loop1
goloop:
	addi $sp,$sp,-4
	sw $a1,0($sp)
	li $s0,0
	la $t5,($t0)
	addi $t9,$t9,1
	j loop
negative1:
	addi $t1,$t1,1
	li $s5,10
	div $s1,$s5
	mflo $s1
	li $a1,0
negloop:
	beqz $s0,gonegloop
	add $s0,$s0,-1
	lb $s2,($t1)
	addi $s2,$s2,-48
	mul $a2,$s2,$s1
	add $a1,$a1,$a2
	li $s5,10
	div $s1,$s5
	mflo $s1
	addi $t1,$t1,1
	j negloop
gonegloop:
	mul $a1,$a1,-1
	addi $sp,$sp,-4
	sw $a1,0($sp)
	li $s0,0
	la $t5,($t0)
	addi $t9,$t9,1
	j loop
endnegative1:
	addi $t1,$t1,1
	li $s5,10
	div $s1,$s5
	mflo $s1
	li $a1,0
endnegloop:
	beqz $s0,endgonegloop
	add $s0,$s0,-1
	lb $s2,($t1)
	addi $s2,$s2,-48
	mul $a2,$s2,$s1
	add $a1,$a1,$a2
	li $s5,10
	div $s1,$s5
	mflo $s1
	addi $t1,$t1,1
	j endnegloop
endgonegloop:
	mul $a1,$a1,-1
	addi $sp,$sp,-4
	sw $a1,0($sp)
	li $s0,0
	la $t5,($t0)
	addi $t9,$t9,1
	j success
plus:
	slti $s7,$t9,2
	beq $s7,1,illegal
	lw $s5,0($sp)
	lw $s6,4($sp)
	addi $sp,$sp,8
	add $s5,$s5,$s6
	addi $sp,$sp,-4
	sw $s5,0($sp)
	li $s0,0
	addi $t0,$t0,1
	la $t5,($t0)
	addi $t5,$t5,1
	addi $t9,$t9,-1
	j loop
minus:
	addi $t0,$t0,1
	lb $s1,($t0)
	li $v0,47
	li $v1,58
	slt $t1,$v0,$s1
	slt $t2,$s1,$v1
	addi $t0,$t0,-1
	beqz $t1,minus1
	beqz $t2,minus1
	j negative
minus1:
	slti $s7,$t9,2
	beq $s7,1,illegal
	lw $s5,0($sp)
	lw $s6,4($sp)
	addi $sp,$sp,8
	mul $s5,$s5,-1
	add $s5,$s5,$s6
	addi $sp,$sp,-4
	sw $s5,0($sp)
	li $s0,0
	addi $t0,$t0,1
	la $t5,($t0)
	addi $t5,$t5,1
	addi $t9,$t9,-1
	j loop
multi:
	slti $s7,$t9,2
	beq $s7,1,illegal
	lw $s5,0($sp)
	lw $s6,4($sp)
	addi $sp,$sp,8
	mul $s5,$s5,$s6
	addi $sp,$sp,-4
	sw $s5,0($sp)
	li $s0,0
	addi $t0,$t0,1
	la $t5,($t0)
	addi $t5,$t5,1
	addi $t9,$t9,-1
	j loop
divide:
	slti $s7,$t9,2
	beq $s7,1,illegal
	lw $s5,0($sp)
	lw $s6,4($sp)
	addi $sp,$sp,8
	div $s6,$s5
	mflo $s5
	addi $sp,$sp,-4
	sw $s5,0($sp)
	li $s0,0
	addi $t0,$t0,1
	la $t5,($t0)
	addi $t5,$t5,1
	addi $t9,$t9,-1
	j loop
success:
	li $t8,1
	bne $t9,$t8,illegal
	la $a0,string2
	li $v0,4
	syscall
	lw $a0,0($sp)
	addi $sp,$sp,4
	li $v0,1
	syscall
	la $a0,enter
	li $v0,4
	syscall
	j end
illegal:
	la $a0,string3
	li $v0,4
	syscall
end: