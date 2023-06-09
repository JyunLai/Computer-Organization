.data
	string1:.asciiz "Please input the year in A.D.:\n\0"
	string2:.asciiz "The corresponding Chinese Era year is \0"
	Jia:.asciiz "Jia\0"
	Yi:.asciiz "Yi\0"
	Bing:.asciiz "Bing\0"
	Ding:.asciiz "Ding\0"
	Wu:.asciiz "Wu\0"
	Ji:.asciiz "Ji\0"
	Geng:.asciiz "Geng\0"
	Xin:.asciiz "Xin\0"
	Ren:.asciiz "Ren\0"
	Gui:.asciiz "Gui\0"
	Zi:.asciiz "Zi.\n\0"
	Chou:.asciiz "Chou.\n\0"
	Yin:.asciiz "Yin.\n\0"
	Mao:.asciiz "Mao.\n\0"
	Chen:.asciiz "Chen.\n\0"
	Si:.asciiz "Si.\n\0"
	Wuu:.asciiz "Wu.\n\0"
	Wei:.asciiz "Wei.\n\0"
	Shen:.asciiz "Shen.\n\0"
	You:.asciiz "You.\n\0"
	Xu:.asciiz "Xu.\n\0"
	Hai:.asciiz "Hai.\n\0"
	dash:.asciiz "-\0"
.text
main:
START:
	li $v0 4
	la $a0,string1
	syscall				#print "Please input the year in A.D.:"
	li $v0 5
	syscall				#read the year
	li $t1 10
	li $t2 12
	div $v0,$t1
	mfhi $t4			#divide the year by 10, and then the remainder will indicate the corresponding Heavenly Stems
	div $v0,$t2
	mfhi $t5			#divide the year by 12, and then the remainder will indicate the corresponding Earthly Branches
	li $s0 0
	li $s1 1
	li $s2 2
	li $s3 3
	li $s4 4
	li $s5 5
	li $s6 6
	li $s7 7
	li $t0 8
	li $t1 9
	li $t2 10
	li $t3 11
	li $v0 4
	la $a0,string2
	syscall				#print "The corresponding Chinese Era year is "
	beq $t4,$s0,geng		#judge the corresponding Heavenly Stems
	beq $t4,$s1,xin
	beq $t4,$s2,ren
	beq $t4,$s3,gui
	beq $t4,$s4,jia
	beq $t4,$s5,yi
	beq $t4,$s6,bing
	beq $t4,$s7,ding
	beq $t4,$t0,wu
	beq $t4,$t1,ji
	EXIT1:
	li $v0 4
	syscall				#print the Heavenly Stems
	li $v0 4
	la $a0,dash
	syscall				#print "-"
	beq $t5,$s0,shen		#judge the corresponding Earthly Branches
	beq $t5,$s1,you
	beq $t5,$s2,xu
	beq $t5,$s3,hai
	beq $t5,$s4,zi
	beq $t5,$s5,chou
	beq $t5,$s6,yin
	beq $t5,$s7,mao
	beq $t5,$t0,chen
	beq $t5,$t1,si
	beq $t5,$t2,wuu
	beq $t5,$t3,wei
	EXIT2:
	li $v0 4
	syscall				#print the Earthly Branches
	j START				#jump to the start of the program
jia:
	la $a0,Jia			#let MEM[$a0]=corresponding Heavenly Stems
	j EXIT1				#jump to print Heavenly Stems, and continue to judge Earthly Branches
yi:
	la $a0,Yi
	j EXIT1
bing:
	la $a0,Bing
	j EXIT1
ding:
	la $a0,Ding
	j EXIT1
wu:
	la $a0,Wu
	j EXIT1
ji:
	la $a0,Ji
	j EXIT1
geng:
	la $a0,Geng
	j EXIT1
xin:
	la $a0,Xin
	j EXIT1
ren:
	la $a0,Ren
	j EXIT1
gui:
	la $a0,Gui
	j EXIT1
zi:
	la $a0,Zi			#let MEM[$a0]=corresponding Earthly Branches
	j EXIT2				#jump to print the Earthly Branches, and restart the program
chou:
	la $a0,Chou
	j EXIT2
yin:
	la $a0,Yin
	j EXIT2
mao:
	la $a0,Mao
	j EXIT2
chen:
	la $a0,Chen
	j EXIT2
si:
	la $a0,Si
	j EXIT2
wuu:
	la $a0,Wuu
	j EXIT2
wei:
	la $a0,Wei
	j EXIT2
shen:
	la $a0,Shen
	j EXIT2
you:
	la $a0,You
	j EXIT2
xu:
	la $a0,Xu
	j EXIT2
hai:
	la $a0,Hai
	j EXIT2