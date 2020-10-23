.data 
.include "includes.asm"

.text

addi t6, zero, 10
addi t5, zero, 27
addi a5, zero, 115

# Polling do teclado e echo na tela
	li s0,0			# zera o contador
LOOPGAME:
	addi s0,s0,1		# incrementa o contador
	jal KEY       		# le o teclado 	non-blocking
	j LOOPGAME		# volta ao loop

### Apenas verifica se há tecla pressionada
KEY:	li t1,0xFF200000		# carrega o endereço de controle do KDMMIO
	lw t0,0(t1)			# Le bit de Controle Teclado
	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,FIM   	   	# Se não há tecla pressionada então vai para FIM
  	lw t2,4(t1)  			# le o valor da tecla tecla
  	beq t2,t6, CARREGAIMG1
  	beq t2,a5, CARREGAC1
  	sw t2,12(t1)  			# escreve a tecla pressionada no display
  	j FIM
CARREGAIMG1:
	li t1,0xFF000000		# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00		# endereco final 
	la s1,mk			# endereço dos dados da tela na memoria
	addi s1,s1,8			# primeiro pixels depois das informações de nlin ncol
LOOPIMG1:
 	beq t1,t2,CARREGAIMG2		# Se for o último endereço então sai do loop
	lw t3,0(s1)			# le um conjunto de 4 pixels : word
	sw t3,0(t1)			# escreve a word na memória VGA
	addi t1,t1,4			# soma 4 ao endereço
	addi s1,s1,4
	j LOOPIMG1			# volta a verificar
CARREGAIMG2:
	li t1,0xFF000000		# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00		# endereco final 
	la s1,teste2			# endereço dos dados da tela na memoria
	addi s1,s1,8			# primeiro pixels depois das informações de nlin ncol
LOOPIMG2:
 	beq t1,t2,CARREGAIMG3		# Se for o último endereço então sai do loop
	lw t3,0(s1)			# le um conjunto de 4 pixels : word
	sw t3,0(t1)			# escreve a word na memória VGA
	addi t1,t1,4			# soma 4 ao endereço
	addi s1,s1,4
	j LOOPIMG2			# volta a verificar
CARREGAIMG3:
	li t1,0xFF000000		# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00		# endereco final 
	la s1,teste3			# endereço dos dados da tela na memoria
	addi s1,s1,8			# primeiro pixels depois das informações de nlin ncol
LOOPIMG3:
 	beq t1,t2,CARREGAIMG4		# Se for o último endereço então sai do loop
	lw t3,0(s1)			# le um conjunto de 4 pixels : word
	sw t3,0(t1)			# escreve a word na memória VGA
	addi t1,t1,4			# soma 4 ao endereço
	addi s1,s1,4
	j LOOPIMG3			# volta a verificar

CARREGAIMG4:
	li t1,0xFF000000		# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00		# endereco final 
	la s1,teste4			# endereço dos dados da tela na memoria
	addi s1,s1,8			# primeiro pixels depois das informações de nlin ncol
LOOPIMG4:
 	beq t1,t2,CARREGAIMG5		# Se for o último endereço então sai do loop
	lw t3,0(s1)			# le um conjunto de 4 pixels : word
	sw t3,0(t1)			# escreve a word na memória VGA
	addi t1,t1,4			# soma 4 ao endereço
	addi s1,s1,4
	j LOOPIMG4			# volta a verificar

CARREGAIMG5:
	li t1,0xFF000000		# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00		# endereco final 
	la s1,teste5			# endereço dos dados da tela na memoria
	addi s1,s1,8			# primeiro pixels depois das informações de nlin ncol
LOOPIMG5:
 	beq t1,t2,CARREGAIMG6		# Se for o último endereço então sai do loop
	lw t3,0(s1)			# le um conjunto de 4 pixels : word
	sw t3,0(t1)			# escreve a word na memória VGA
	addi t1,t1,4			# soma 4 ao endereço
	addi s1,s1,4
	j LOOPIMG5			# volta a verificar

CARREGAIMG6:
	li t1,0xFF000000		# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00		# endereco final 
	la s1,teste6			# endereço dos dados da tela na memoria
	addi s1,s1,8			# primeiro pixels depois das informações de nlin ncol
LOOPIMG6:
 	beq t1,t2,CARREGAIMG7		# Se for o último endereço então sai do loop
	lw t3,0(s1)			# le um conjunto de 4 pixels : word
	sw t3,0(t1)			# escreve a word na memória VGA
	addi t1,t1,4			# soma 4 ao endereço
	addi s1,s1,4
	j LOOPIMG6			# volta a verificar

CARREGAIMG7:
	li t1,0xFF000000		# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00		# endereco final 
	la s1,teste7			# endereço dos dados da tela na memoria
	addi s1,s1,8			# primeiro pixels depois das informações de nlin ncol
LOOPIMG7:
 	beq t1,t2,CARREGAIMG8		# Se for o último endereço então sai do loop
	lw t3,0(s1)			# le um conjunto de 4 pixels : word
	sw t3,0(t1)			# escreve a word na memória VGA
	addi t1,t1,4			# soma 4 ao endereço
	addi s1,s1,4
	j LOOPIMG7			# volta a verificar

CARREGAIMG8:
	li t1,0xFF000000		# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00		# endereco final 
	la s1,teste8			# endereço dos dados da tela na memoria
	addi s1,s1,8			# primeiro pixels depois das informações de nlin ncol
LOOPIMG8:
 	beq t1,t2,CARREGAIMG9		# Se for o último endereço então sai do loop
	lw t3,0(s1)			# le um conjunto de 4 pixels : word
	sw t3,0(t1)			# escreve a word na memória VGA
	addi t1,t1,4			# soma 4 ao endereço
	addi s1,s1,4
	j LOOPIMG8			# volta a verificar

CARREGAIMG9:
	li t1,0xFF000000		# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00		# endereco final 
	la s1,teste9			# endereço dos dados da tela na memoria
	addi s1,s1,8			# primeiro pixels depois das informações de nlin ncol
LOOPIMG9:
 	beq t1,t2,FIM			# Se for o último endereço então sai do loop
	lw t3,0(s1)			# le um conjunto de 4 pixels : word
	sw t3,0(t1)			# escreve a word na memória VGA
	addi t1,t1,4			# soma 4 ao endereço
	addi s1,s1,4
	j LOOPIMG9			# volta a verificar

CARREGAC1:
	li t1,0xFF000000		# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00		# endereco final 
	la s1,c1			# endereço dos dados da tela na memoria
	addi s1,s1,8			# primeiro pixels depois das informações de nlin ncol
LOOPC1:
 	beq t1,t2,CARREGAC2		# Se for o último endereço então sai do loop
	lw t3,0(s1)			# le um conjunto de 4 pixels : word
	sw t3,0(t1)			# escreve a word na memória VGA
	addi t1,t1,4			# soma 4 ao endereço
	addi s1,s1,4
	j LOOPC1			# volta a verificar

CARREGAC2:
	li t1,0xFF000000		# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00		# endereco final 
	la s1,c2			# endereço dos dados da tela na memoria
	addi s1,s1,8			# primeiro pixels depois das informações de nlin ncol
LOOPC2:
 	beq t1,t2,CARREGAC3		# Se for o último endereço então sai do loop
	lw t3,0(s1)			# le um conjunto de 4 pixels : word
	sw t3,0(t1)			# escreve a word na memória VGA
	addi t1,t1,4			# soma 4 ao endereço
	addi s1,s1,4
	j LOOPC2			# volta a verificar


CARREGAC3:
	li t1,0xFF000000		# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00		# endereco final 
	la s1,c3			# endereço dos dados da tela na memoria
	addi s1,s1,8			# primeiro pixels depois das informações de nlin ncol
LOOPC3:
 	beq t1,t2,CARREGAC4		# Se for o último endereço então sai do loop
	lw t3,0(s1)			# le um conjunto de 4 pixels : word
	sw t3,0(t1)			# escreve a word na memória VGA
	addi t1,t1,4			# soma 4 ao endereço
	addi s1,s1,4
	j LOOPC3			# volta a verificar

CARREGAC4:
	li t1,0xFF000000		# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00		# endereco final 
	la s1,c4			# endereço dos dados da tela na memoria
	addi s1,s1,8			# primeiro pixels depois das informações de nlin ncol
LOOPC4:
 	beq t1,t2,FIM			# Se for o último endereço então sai do loop
	lw t3,0(s1)			# le um conjunto de 4 pixels : word
	sw t3,0(t1)			# escreve a word na memória VGA
	addi t1,t1,4			# soma 4 ao endereço
	addi s1,s1,4
	j LOOPC4			# volta a verificar

FIM:	ret				# retorna

