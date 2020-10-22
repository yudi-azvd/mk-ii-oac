####################################################
#  Programa de exemplo de interrupçao do teclado   #
#  usando o Keyboard Display MMIO Tool		   #
#  ISC Set 2019				           #
#  Marcus Vinicius			           #
####################################################

.data
.include "idleteste.s"

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


# rotina de tratamento da interrupção
KDInterrupt:	csrrci zero,0,1 	# clear o bit de habilitação de interrupção global em ustatus (reg 0)

  		lw t2,4(s11)  			# le a tecla
		sw t2,12(s11) 			# escreve no display
		mv s10, t2
		
		csrrsi zero,0,0x10 	# seta o bit de habilitação de interrupção em ustatus 
		uret			# retorna PC=uepc		

.include "imprimePersonagem.s"
