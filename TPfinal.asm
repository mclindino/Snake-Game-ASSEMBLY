.data
	inicio: .space 4
	preto: .word 0x000000
	branco: .word 0xFFFFFF
	vermelho: .word 0xB22222
	pixels: .word 8192
	strMenu: .asciiz "THE LIFE SNAKE!\nDeseja começar?"
		
.text
.main:
	jal menu
	nop
	la $t0, inicio
	lw $t1, pixels
	lw $t2, preto
	jal storaPontos
	nop
	lui $a0, 0x1001
	addi $a0, $a0, 0x8004
	li $v0, 4
	syscall
	li $s7, 0
	move $a0, $s7
	li $v0, 1
	syscall
	li $s7, 0
	lw $t3, branco
	li $s0, 16400
	lw $s6, vermelho
	li $s2, 52
	lui $t4, 0xffff
	ori $t4, $t4, 0x0000
	addi $t5, $t4, 0x0004
	jal desenha_fundo
	nop

desenhou:
	jal cobra
	nop
	jal maca
	nop
	j esquerdaFinal
	nop
	
desenha_fundo:
	beq $t1, $zero, desenhou
	nop
	slti $s5, $t1, 8065
	bne $s5, $zero, normalmentiroso
	nop
	sw $s6, 0($t0)
	addi $t0, $t0, 4
	addi $t1, $t1, -1
	j desenha_fundo
	nop
normalmentiroso:
	slti $s5, $t1, 129
	bne $s5, 1, normal
	nop
	sw $s6, 0($t0)
	addi $t0, $t0, 4
	addi $t1, $t1, -1
	j desenha_fundo
	nop
normal:
	sw $t2, 0($t0)
	addi $t0, $t0, 4
	addi $t1, $t1, -1
	j desenha_fundo
	nop
	
cobra:
	la $t0, inicio
	add $t6, $t0, $s0
	move $s0, $t6
	addi $s2, $s2, 8 
	add $s1, $t6, $s2
for:
	beq $t6, $s1, cabecinhacompleta
	nop
	sw $t3, 0($t6)
	addi $t6, $t6, 4
	j for
	nop
cabecinhacompleta:
	jr $ra
	nop

digitouEsquerda:
	lw $t7, 0($t5)
	beq $t7, 119, w
	nop
	beq $t7, 115, s
	nop
	j continuaEsquerda
	nop

d: 	
	beq $t8, $s0, esquerda
	nop
	sw $t2, 0($s0)
	beq $s3, 3, esquerdaC
	nop
	beq $s3, 2, esquerdaB
	nop
esquerdaC:
	sub $s0, $s0, 512
	j continua1
	nop
esquerdaB:
	add $s0, $s0, 512
	j continua1
	nop
continua1:
	add $s1, $s1, 4
	jal comeu
	nop
	sw $t3, 0($s1)
	li $v0, 32
	li $a0, 50
	syscall
	j d
	nop

esquerdaFinal:	
	sw $t2, 0($s0)
	add $s0, $s0, 4
esquerda:
	li $s3, 0
	sw $t3, 0($s1)
	move $t8, $s1
	lw $t6, 0($t4)
	beq $t6, 1, digitouEsquerda
	nop
continuaEsquerda:	
	add $s1, $s1, 4
	jal comeu
	nop
	li $v0, 32
	li $a0, 50
	syscall
	j esquerdaFinal
	nop
	
digitouCima:
	lw $t7, 0($t5)
	beq $t7, 97, a
	nop
	beq $t7, 100, d
	nop
	j continuaCima
	nop	

w:
	beq $t8, $s0, cima
	nop
	sw $t2, 0($s0)
	beq $s3, 0, cimaE
	nop
	beq $s3, 1, cimaD
	nop
cimaE:
	add $s0, $s0, 4
	j continua
	nop
cimaD:
	sub $s0, $s0, 4
	j continua
	nop
continua:
	sub $s1, $s1, 512
	jal comeu
	nop
	jal cabecinha
	nop
	sw $t3, 0($s1)
	li $v0, 32
	li $a0, 50
	syscall
	j w
	nop

cimaFinal:
	sw $t2, 0($s0)
	subi $s0, $s0, 512
cima:
	li $s3, 3
	jal cabecinha
	nop
	sw $t3, 0($s1)
	move $t8, $s1
	lw $t6, 0($t4)
	beq $t6, 1, digitouCima
	nop
continuaCima:
	subi $s1, $s1, 512
	jal comeu
	nop
	li $v0, 32
	li $a0, 50
	syscall
	j cimaFinal
	nop
	
digitouBaixo:
	lw $t7, 0($t5)
	beq $t7, 97, a
	nop
	beq $t7, 100, d
	nop
	j continuaBaixo
	nop	

s:
	beq $t8, $s0, baixo
	nop
	sw $t2, 0($s0)
	beq $s3, 0, baixoE
	nop
	beq $s3, 1, baixoD
	nop
baixoE:
	addi $s0, $s0, 4
	j continua3
	nop
baixoD:
	subi $s0, $s0, 4
	j continua3
	nop
continua3:
	add $s1, $s1, 512
	jal comeu
	nop
	jal cabecinha
	nop
	sw $t3, 0($s1)
	li $v0, 32
	li $a0, 50
	syscall
	j s
	nop

baixoFinal:
	sw $t2, 0($s0)
	addi $s0, $s0, 512
baixo:
	li $s3, 2
	jal cabecinha
	nop
	sw $t3, 0($s1)
	move $t8, $s1
	lw $t6, 0($t4)
	beq $t6, 1, digitouBaixo
	nop	
continuaBaixo:
	addi $s1, $s1, 512
	jal comeu
	nop
	li $v0, 32
	li $a0, 50
	syscall
	j baixoFinal
	nop	
		
digitouDireita:
	lw $t7, 0($t5)
	beq $t7, 119, w
	nop
	beq $t7, 115, s
	nop
	j continuaDireita
	nop		
						
a: 	
	beq $t8, $s0, direita
	nop
	sw $t2, 0($s0)
	beq $s3, 3, direitaC
	nop
	beq $s3, 2, direitaB
	nop
direitaC:
	subi $s0, $s0, 512
	j continua2
	nop
direitaB:
	addi $s0, $s0, 512
	j continua2
	nop
continua2:
	subi $s1, $s1, 4
	jal comeu
	nop
	jal cabecinha
	nop
	sw $t3, 0($s1)
	li $v0, 32
	li $a0, 50
	syscall
	j a
	nop

direitaFinal:	
	sw $t2, 0($s0)
	add $s0, $s0, -4
direita:
	li $s3, 1
	jal cabecinha
	nop
	sw $t3, 0($s1)
	move $t8, $s1
	lw $t6, 0($t4)
	beq $t6, 1, digitouDireita
	nop
continuaDireita:	
	add $s1, $s1, -4
	jal comeu
	nop
	li $v0, 32
	li $a0, 50
	syscall
	j direitaFinal
	nop
	
cabecinha:
	lui $t9, 0x1001
	slt $t9, $s1, $t9
	beq $t9, 1, end
	nop
	lui $t9, 0x1001
	or $t9, $t9, 0x8000
	slt $t9, $t9, $s1
	beq $t9, 1, end
	nop
	jr $ra
	nop

maca:
	lui $s4, 0x1001
	li $v0, 42
	li $a1, 8192
	syscall
	move $s5, $a0
	sll $s5, $s5, 2
	add $s4, $s4, $s5
	sw $t3, 0($s4)
	add $s4, $s4, 4
	sw $t3, 0($s4)
	add $s4, $s4, 512
	sw $t3, 0($s4)
	sub $s4, $s4, 4
	sw $t3, 0($s4)
	jr $ra
	nop

comeu:
	lw $s5, 0($s1)
	beq $s5, $t3, sumiu
	nop
	jr $ra
	nop

sumiu:
	sw $t2, 0($s4)
	add $s4, $s4, 4
	sw $t2, 0($s4)
	sub $s4, $s4, 512
	sw $t2, 0($s4)
	sub $s4, $s4, 4
	sw $t2, 0($s4)
	addi $s2, $s2, 1
	addi $s7, $s7, 1
	j atualizaPontos
	nop

storaPontos:
	lui $a3, 0x1001
	addi $a3, $a3, 0x8004
	li $s7, 80
	sb $s7, ($a3)
	addi $a3, $a3, 1
	li $s7, 111
	sb $s7, ($a3)
	addi $a3, $a3, 1
	li $s7, 110
	sb $s7, ($a3)
	addi $a3, $a3, 1
	li $s7, 116
	sb $s7, ($a3)
	addi $a3, $a3, 1
	li $s7, 111
	sb $s7, ($a3)
	addi $a3, $a3, 1
	li $s7, 115
	sb $s7, ($a3)
	addi $a3, $a3, 1
	li $s7, 58
	sb $s7, ($a3)
	addi $a3, $a3, 1
	li $s7, 32
	sb $s7, ($a3)
	addi $a3, $a3, 1
	lui $a3, 0x1001
	addi $a3, $a3, 0x8003
	li $s7 10
	sb $s7, ($a3) 
	jr $ra
	nop
	
atualizaPontos:
	lui $a0, 0x1001
	addi $a0, $a0, 0x8003
	li $v0, 4
	syscall
	move $a0, $s7
	li $v0, 1
	syscall
	j maca
	nop
	
menu:
	la $a0, strMenu
	li $v0, 50
	syscall
	bne $a0, 0, end
	nop
	jr $ra	

end: 
	li $v0, 10
	syscall

