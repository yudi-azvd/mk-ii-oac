####################################################
#  Programa de exemplo de interrup�ao do teclado   #
#  usando o Keyboard Display MMIO Tool		   #
#  ISC Set 2019				           #
#  Marcus Vinicius			           #
####################################################

.data
.include "idleteste.s"

.text
# programa do usu�rio

 	la tp,KDInterrupt	# carrega em tp o endere�o base das rotinas de Tratamento da Interrup��o
 	csrrw zero,5,tp 	# seta utvec (reg 5) para o endere�o tp
 	csrrsi zero,0,1 	# seta o bit de habilita��o de interrup��o global em ustatus (reg 0)
	li tp,0x100
 	csrrw zero,4,tp		# habilita a interrup��o do usu�rio

 	li s11,0xFF200000	# Endere�o de controle do KDMMIO
	li t0,0x02		# bit 1 habilita/desabilita a interrup��o
	sw t0,0(s11)   		# Habilita interrup��o do teclado
  
	li a0, 0xFF000000
	mv s2, a0		# s2 eh o end do bitmapdisplay
	la a1, idleteste
	jal imprimeJ	
     
	li s0,0			# zera contador
CONTA:	addi s0,s0,1 		# incrementa contador
	
	li t0, 100
	bne s10,t0, CONTA
	mv s10, zero
	mv a0, s2
	la a1, idleteste
	jal limpaJ
	addi s2, s2, 4
	mv a0, s2
	la a1, idleteste
	jal imprimeJ
	j CONTA			# volta ao loop


# rotina de tratamento da interrup��o
KDInterrupt:	csrrci zero,0,1 	# clear o bit de habilita��o de interrup��o global em ustatus (reg 0)

  		lw t2,4(s11)  			# le a tecla
		sw t2,12(s11) 			# escreve no display
		mv s10, t2
		
		csrrsi zero,0,0x10 	# seta o bit de habilita��o de interrup��o em ustatus 
		uret			# retorna PC=uepc		

.include "imprimePersonagem.s"
