.eqv VGAADDRESSINI0 0xFF000000
.eqv VGAADDRESSFIM0 0xFF012C00
.eqv VGAADDRESSINI1 0xFF100000
.eqv VGAADDRESSFIM1 0xFF112C00
.eqv VGAFRAMESELECT 0xFF200604

.data
framePtr: .word 0xFF000000, 0xFF012C00
frameToShow: .byte 0
pos: .word 0 			# posicao pra iniciar o boneco

.include "./img/idle1.s"
.include "./img/walk1.s"
.include "./img/walk2.s"
.include "./img/walk3.s"
.include "./img/walk4.s"
.include "./img/walk5.s"
.include "./img/walk6.s"
.include "./img/walk7.s"
.include "./img/walk8.s"
.include "./img/walk9.s"
.include "./img/bg.s"

.text
INICIALIZA:
	addi sp, sp, -4
	sw ra, 0(sp)
  	# preenche o fundo
  	la t0, framePtr
  	lw a0, 0(t0)
  	lw a1, 4(t0)
  	la a2, bg
  	jal IMPRIME_TELA
  	jal ESCOLHEFRAME
  	la t0, framePtr
  	lw a0, 0(t0)
  	lw a1, 4(t0)
  	la a2, bg
  	jal IMPRIME_TELA
  	jal ESCOLHEFRAME
  	# sera q compensa fazer um proc pra isso ?
  	
  	#jal TROCAFRAME
  	li t0, 130
  	li t1, 320
  	mul t0, t0, t1
	mv s2, t0			# s2 eh o end do bitmapdisplay
	la t0, pos
	sw s2, 0(t0)
	mv a0, s2
	la a1, idle1
	jal imprimeJ	
     	
    lw ra, 0(sp)
    addi sp, sp, 4
    ret
     	
CONTA:	
	addi sp, sp, -4
	sw ra, 0(sp)
	la t0, pos
	lw s2, 0(t0)
	
	#Aqui vamos fazer a verificacao das teclas
	li t0, 100
	beq s10, t0, DIREITA_P
	li t0, 97
	beq s10, t0, ESQUERDA_P
	
	j FIM_BEQ
ESQUERDA_P:
	addi t0, s2, -4
	li t1, 41600
	blt t0, t1, FIM_BEQ
	addi s2, s2, -4
	jal RENDER_PLAYER
	addi a0, s2, 4
	jal LIMPA_PMAIN
	j FIM_BEQ
DIREITA_P:
	# verifica para nao atravessar a  parede
	addi t0, s2, 4
	li t1, 41882
	bge t0, t1, FIM_BEQ
	# o codigo aqui embaixo imprime o sprite na nova posicao
	addi s2, s2, 4		# adiciona +4 pra fazer ele andar
	jal RENDER_PLAYER
	addi a0, s2, -4
	jal LIMPA_PMAIN
	j FIM_BEQ
RENDER_PLAYER:
	addi sp, sp, -8
	sw ra, 0(sp)
	sw s2, 4(sp)
	jal ESCOLHEFRAME

	#la a1, idle1
	jal trocaSprite
	mv a1, a0
	lw a0, 4(sp)
	jal imprimeJ
	jal TROCAFRAME
	lw ra, 0(sp)
	addi sp, sp, 8
	ret
	#o codigo abaixo limpa o ultimo sprite do jogador
LIMPA_PMAIN:
	addi sp, sp, -8
	sw ra, 0(sp)
	sw a0, 4(sp)
	jal ESCOLHEFRAME
	
	lw a0, 4(sp)
	#mv a0, t0
	la a1, idle1
	la a2, bg
	jal limpaJ
	jal ESCOLHEFRAME
	
	lw ra, 0(sp)
	addi sp, sp, 8
	ret

FIM_BEQ:
	mv s10, zero
	la t0, pos
	sw s2, 0(t0)
	lw ra, 0(sp)
	addi sp, sp, 4
	ret

.include "imprimePersonagem.s"
.include "escolheFrame.s"
.include "teste_fundo.asm"
