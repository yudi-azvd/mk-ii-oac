.data
#TELA: .word 0xFF000000
#.include "fundoW.s"
#.include "./img/bg.s"

.text
# colocar em a0 o endereco da frame
# em a1 o endereco final
# em a2 o endereco da tela inteira

IMPRIME_TELA:
	mv t1, a0
	mv t2, a1
	mv t3, a2
	addi t3, t3, 8

LOOP_TELA: 	
	beq t1, t2, TERMINA_FUNDO 	#se chegar no final, acaba
	lw t4, 0(t3)			#carrega o pixel da imagem			
	sw t4, 0(t1)			# guarda na tela
	addi t1, t1, 4			#passa pro prox
	addi t3, t3, 4			#passa pro prox
	j LOOP_TELA			# volta pro loop		
				
TERMINA_FUNDO:
	#li a7, 10
	#ecall
	ret
	
