.eqv VGAADDRESSINI0 0xFF000000
.eqv VGAADDRESSFIM0 0xFF012C00
.eqv VGAADDRESSINI1 0xFF100000
.eqv VGAADDRESSFIM1 0xFF112C00
.eqv VGAFRAMESELECT 0xFF200604

.data
framePtr: .word 0xFF000000, 0xFF012C00
frameToShow: .byte 0
pos: .word 0 			# posicao pra iniciar o boneco
enemy_pos: .word 0
vida: .word 24, 0
enemy_vida: .word 4, 0
tempo: .word 60, 140, 0

.macro done
li a7, 10
ecall
.end_macro

.include "sprites.s"

.text
# se tiver como rejogar lembrar de resetar as variaveis
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
  	addi t0, t0, 60
	mv s2, t0			# s2 eh o end do bitmapdisplay
	la t0, pos
	sw s2, 0(t0)
	mv a0, s2
	la a1, idle1
	jal imprimeJ	
	
	# imprimir o inimigo
	li t0, 130
  	li t1, 320
  	mul t0, t0, t1
  	addi t0, t0, 220
	mv s2, t0			# s2 eh o end do bitmapdisplay
    la t0, enemy_pos
	sw s2, 0(t0)
	mv a0, s2
	la a1, enemyidle1
	jal imprimeJ	
	
	#la a1, coracaoCheio
	la a0, vida
	lw a0, 0(a0)
	jal QUAL_VIDA
	mv a1, a0
	li t0, 20
	li t1, 320
	mul t0, t0, t1
	addi t0, t0, 10
	mv a0, t0
	la t0, vida
	sw a0, 4(t0)
	jal imprimeJ
	
	# inicializa o tempo
	#li a7, 30
	#ecall
	#la t0, tempo
	#sw a0, 8(t0)
	
    lw ra, 0(sp)
    addi sp, sp, 4
    ret
     	
CONTA:	
	addi sp, sp, -4
	sw ra, 0(sp)
	la t0, pos
	lw s2, 0(t0)
	
	# descomentar para o tempo funcionar
	# renderizacao do tempo
	#li a7, 30
	#ecall			# a0 = tempo atual
	#la t0, tempo
	#lw t1, 8(t0)		# tempo inicial
	#sub a0, a0, t1 	# diferenca entre tempo
	#li t1, 1000
	#div a0, a0, t1	# diferenca entre segundos
	#lw t2, 0(t0)		# t2 = 60
	#lw t3, 4(t0)		# t3 = pos no bitmap pra printar o tempo
	#sub t2, t2, a0
	# AQUI VERIFICA SE ACABOU O TEMPO
	#blt t2, zero, END_GAME
	#li t1, 10
	#div t4, t2, t1
	#rem t5, t2, t1 		
	#addi sp, sp, -12
	#sw t5, 0(sp)		# unidade 
	#sw t4, 4(sp)		# dezena
	#sw t3, 8(sp)		# pos pra printar
	# a1 = sprite
	# a0 = t3 
	#mv a0, t4
	#jal ESCOLHE_NUMERO
	#mv a1, a0
	#lw a0, 8(sp)
	#jal imprimeJ
	#lw a0, 0(sp)
	#jal ESCOLHE_NUMERO
	#mv a1, a0
	#lw a0, 8(sp)
	#addi a0, a0, 20
	#jal imprimeJ
	# apaga o numero
	# jal ESCOLHEFRAME
	# lw a0, 8(sp)
	# la a1, coracaoCheio
	# la a2, bg
	# jal limpaJ
	# lw a0, 8(sp)
	# addi a0, a0, 20
	# la a1, coracaoCheio
	# la a2, bg
	# jal limpaJ
	# jal ESCOLHEFRAME
	# # apaga o numero
	# addi sp, sp, 12


	#Aqui vamos fazer a verificacao das teclas
	li t0, 100
	beq s10, t0, DIREITA_P
	li t0, 97
	beq s10, t0, ESQUERDA_P
	li t0, 115
	beq s10, t0, ABAIXA_P
	li t0, 106
	beq s10, t0, SOCO_P
	li t0, 107
	beq s10, t0, CHUTE_P
	
	# default vai ficar parado
	la a0, idle1
	mv a1, s2
	jal RENDER_PLAYER
	mv a0, s2
	jal LIMPA_PMAIN
	j FIM_BEQ

RENDER_PLAYER:
	# mandar em a1 a posicao e em a0 o sprite a ser printado
	addi sp, sp, -12
	sw ra, 0(sp)
	sw a1, 4(sp)			# a0 eh a posicao no bitmap
	sw a0, 8(sp)			# a1 eh o sprite do jogador
	jal ESCOLHEFRAME
	
	lw a1, 8(sp)			# a1 eh o sprite do jogador
	lw a0, 4(sp)			# a0 eh a posicao no bitmap
	jal imprimeJ
	#imprime o inimigo
	la a1, enemyidle1
	la t0, enemy_pos
	lw a0, 0(t0)
	jal imprimeJ
	# imprime coracao teste	
	# la a1, coracaoCheio
	# trocar o codigo abaixo 
	la a0, vida
	lw a0, 0(a0)
	jal QUAL_VIDA
	mv a1, a0
	la t0, vida
	lw a0, 4(t0)
	jal imprimeJ			# a1 = sprite pra printar a0 = posicao 
	jal TROCAFRAME
	lw ra, 0(sp)
	addi sp, sp, 12
	ret
	#o codigo abaixo limpa o ultimo sprite do jogador
LIMPA_PMAIN:
	addi sp, sp, -8
	sw ra, 0(sp)
	sw a0, 4(sp)
	jal ESCOLHEFRAME
	
	# limpar player
	la t0, pos			
	lw a0, 0(t0)	
	la a1, chute4
	la a2, bg
	jal limpaJ
	# limpar inimigo
	la t0, enemy_pos
	lw a0, 0(t0)
	la a1, idle1
	la a2, bg
	jal limpaJ
	la a1, coracaoCheio
	la t0, vida
	lw a0, 4(t0)
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

ESPERA_AI:		# manda em a0 qnt tempo quer esperar
	addi sp, sp, -4
	sw ra, 0(sp)
	li a7, 32
	ecall
	lw ra, 0(sp)
	addi sp, sp, 4
	ret

END_GAME:
	done
.include "movimentosPersonagem.s"
.include "imprimePersonagem.s"
.include "escolheFrame.s"
.include "teste_fundo.asm"
.include "BoxCollider.s"
