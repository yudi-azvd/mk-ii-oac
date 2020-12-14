.data
sprite: .word 0,0,0,0
#.include "./img/idle1.s"

.macro done
li a7, 10
ecall
.end_macro

.text
# a0 = endereco do BITMAP DISPLAY
# a1 = endereco da IMAGEM
imprimeJ:
	###################################
	#                                 #
	#     QUANDO FOR FAZER O JOGO     #
	#     LEMBRAR DE USAR PILHA PRA   #
	#     SALVAR OS REG SALVOS        # 
	#                                 #
	###################################
	
	addi sp, sp, -28
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
	sw s3, 12(sp)
	sw s4, 16(sp)
	sw s5, 20(sp)
	sw s6, 24(sp)
	
	mv s0, 	a1	#endereco do perso q vou printar
	mv s1,	a0	# a coordenada, ai em baixo eu somo ao endereco
	
	la t0, framePtr 
	lw t0, 0(t0)
	add s1, s1, t0	# endereco no bitmap
	
	li s2, 0 	# contador da linha
	li s5, 0		#contador da coluna
	lw s3, 0(s0) 	# largura da imagem
	#li t1, 4
	#div s3, s3, t1
	lw s4, 4(s0)	#altura da imagem
	addi s0, s0, 8
forIMP:
	bge s2, s4, fimIMP
	mv s5, zero
	j forColIMP
testeIMP:
	addi s2, s2, 1
	addi s1, s1, 320
	#li t3, 4
	#mul t3, t3, s3
	sub s1, s1, s3
	j forIMP
forColIMP:
	bge s5, s3, testeIMP
	lb t1, 0(s0)
	li t0, 0xFFFFFFC7
	beq t1, t0, OI_PERSO
	sb t1, 0(s1)
	#lw t1, 0(s0)
	#sw t1, 0(s1)
OI_PERSO:
	addi s1, s1, 1
	addi s0, s0, 1
	addi s5, s5, 1
	j forColIMP

	
	
fimIMP:	
	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	lw s3, 12(sp)
	lw s4, 16(sp)
	lw s5, 20(sp)
	lw s6, 24(sp)
	addi sp, sp, 28
	ret
#
##
##
#
#
#
#
#
#
#	FUNCAO ABAIXO EH PARA LIMPAR O SPRITE
#	ARRUMAR PARA PRINTAR O FUNDO DA TELA EM VEZ DE PRETO
limpaJ:
	
	addi sp, sp, -28
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
	sw s3, 12(sp)
	sw s4, 16(sp)
	sw s5, 20(sp)
	sw s6, 24(sp)
	
	mv s0, 	a1	#idle1 #endereco do perso q vou printar
	mv s1,	a0	#0xFF000000 # coordenada do bitmap display
	
	la t0, framePtr
	lw t0, 0(t0)
	add s1, s1, t0
	
	mv t0,	a2	# endereco q vou cobrir
	addi t0, t0, 8
	add t0, t0, a0
	
	#mv 
	#la s0, idle1
	#li s1, 0xFF000000
	li s2, 0 	# contador da linha
	li s5, 0		#contador da coluna
	lw s3, 0(s0) 	# largura da imagem
	li t1, 4
	div s3, s3, t1
	lw s4, 4(s0)	#altura da imagem
	#li t1, 0x00000000	#escolhe a cor ou o fundo q vai cobrir
	#mul t0, s3, s4	# tamanho do vetor imagem
forLIMP:
	bge s2, s4, fimLIMP
	mv s5, zero
	j forColLIMP
testeLIMP:
	#done
	addi s2, s2, 1
	addi s1, s1, 320
	addi t0, t0, 320
	li t3, 4
	mul t3, t3, s3
	sub s1, s1, t3
	sub t0, t0, t3
	j forLIMP
forColLIMP:
	bge s5, s3, testeLIMP
	lw t1, 0(t0)
	sw t1, 0(s1)
	addi s1, s1, 4
	addi t0, t0, 4
	addi s5, s5, 1
	j forColLIMP

	
	
fimLIMP:	
	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	lw s3, 12(sp)
	lw s4, 16(sp)
	lw s5, 20(sp)
	lw s6, 24(sp)
	addi sp, sp, 28
	ret

# TROCA SPRITE

trocaSprite:
	la t2, sprite
	lbu t0, 0(t2)
	#PrintInt(t1)
	li t1, 0
	beq t0, t1, ZERO
	li t1, 1
	beq t0, t1, UM
	li t1, 2
	beq t0, t1, DOIS
	li t1, 3
	beq t0, t1, TRES
	li t1, 4
	beq t0, t1, QUATRO
	li t1, 5
	beq t0, t1, CINCO
	li t1, 6
	beq t0, t1, SEIS
	li t1, 7
	beq t0, t1, SETE
	li t1, 8
	beq t0, t1, OITO
	ret
ZERO: la a0, walk1
	addi t0, t0, 1
	li t3, 9
	rem t0, t0, t3
	sb t0, 0(t2)
	ret
UM: la a0, walk2
	addi t0, t0, 1
	li t3, 9
	rem t0, t0, t3
	sb t0, 0(t2)
	ret
DOIS: la a0, walk3
	addi t0, t0, 1
	li t3, 9
	rem t0, t0, t3
	sb t0, 0(t2)
	ret
TRES: la a0, walk4
	addi t0, t0, 1
	li t3, 9
	rem t0, t0, t3
	sb t0, 0(t2)
	ret
QUATRO: la a0, walk5
	addi t0, t0, 1
	li t3, 9
	rem t0, t0, t3
	sb t0, 0(t2)
	ret
CINCO: la a0, walk6
	addi t0, t0, 1
	li t3, 9
	rem t0, t0, t3
	sb t0, 0(t2)
	ret
SEIS: la a0, walk7
	addi t0, t0, 1
	li t3, 9
	rem t0, t0, t3
	sb t0, 0(t2)
	ret
SETE: la a0, walk8
	addi t0, t0, 1
	li t3, 9
	rem t0, t0, t3
	sb t0, 0(t2)
	ret
OITO: la a0, walk9
	addi t0, t0, 1
	li t3, 9
	rem t0, t0, t3
	sb t0, 0(t2)
	ret
