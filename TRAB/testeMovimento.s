.eqv VGAADDRESSINI0 0xFF000000
.eqv VGAADDRESSFIM0 0xFF012C00
.eqv VGAADDRESSINI1 0xFF100000
.eqv VGAADDRESSFIM1 0xFF112C00
.eqv VGAFRAMESELECT 0xFF200604

.data
framePtr: .word 0xFF000000, 0xFF012C00
frameToShow: .byte 0

.include "./img/idle1.s"
.include "./img/walk1.s"
.include "./img/bg.s"

.text
# programa do usuário

 	la tp,KDInterrupt	# carrega em tp o endereço base das rotinas de Tratamento da Interrupção
 	csrrw zero,5,tp 	# seta utvec (reg 5) para o endereço tp
 	csrrsi zero,0,1 	# seta o bit de habilitação de interrupção global em ustatus (reg 0)
	li tp,0x100
 	csrrw zero,4,tp		# habilita a interrupção do usuário

 	li s11,0xFF200000	# Endereço de controle do KDMMIO
	li t0,0x02		# bit 1 habilita/desabilita a interrupção
	sw t0,0(s11)   		# Habilita interrupção do teclado
  	li s10, 0
  	
  	# preenche o fundo
  	la t0, framePtr
  	lw a0, 0(t0)
  	lw a1, 4(t0)
  	la a2, bg
  	#jal IMPRIME_TELA
  	#jal ESCOLHEFRAME
  	la t0, framePtr
  	lw a0, 0(t0)
  	lw a1, 4(t0)
  	la a2, bg
  	#jal IMPRIME_TELA
  	#jal ESCOLHEFRAME
  	# sera q compensa fazer um proc pra isso ?
  	
  	#jal TROCAFRAME
  	li t0, 130
  	li t1, 320
  	mul t0, t0, t1
	mv s2, t0			# s2 eh o end do bitmapdisplay
	mv a0, s2
	la a1, idle1
	jal imprimeJ	
     
	li s0,0			# zera contador
CONTA:	addi s0,s0,1 		# incrementa contador
	
	#Aqui vamos fazer a verificacao das teclas
	li t0, 100
	bne s10,t0, CONTA
	mv s10, zero
	
	# o codigo aqui embaixo imprime o sprite na nova posicao
	
	addi s2, s2, 4		# adiciona +4 pra fazer ele andar
	jal ESCOLHEFRAME
	
	mv a0, s2
	la a1, idle1
	jal imprimeJ
	jal TROCAFRAME
	
	#o codigo abaixo limpa o ultimo sprite do jogador
	addi s2, s2, -4
	jal ESCOLHEFRAME
	
	mv a0, s2
	la a1, idle1
	la a2, bg
	jal limpaJ
	addi s2, s2, 4
	jal ESCOLHEFRAME
	
	j CONTA			# volta ao loop


# rotina de tratamento da interrupção
KDInterrupt:	csrrci zero,0,1 	# clear o bit de habilitação de interrupção global em ustatus (reg 0)

  		lw t2,4(s11)  			# le a tecla
		sw t2,12(s11) 			# escreve no display
		mv s10, t2
		
		csrrsi zero,0,0x10 	# seta o bit de habilitação de interrupção em ustatus 
		uret			# retorna PC=uepc		

.include "imprimePersonagem.s"
.include "escolheFrame.s"
.include "teste_fundo.asm"
