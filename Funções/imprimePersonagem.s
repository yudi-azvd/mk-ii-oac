.eqv VGAADDRESSINI0 0xFF000000
.eqv VGAADDRESSFIM0 0xFF012C00
.eqv VGAADDRESSINI1 0xFF100000
.eqv VGAADDRESSFIM1 0xFF112C00
.eqv VGAFRAMESELECT 0xFF200604

.data

frameToShow: .word 0xFF000000
framePtr: .word 0xFF000000

.macro done
li a7, 10
ecall
.end_macro

.text
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
	
	mv s0, 	a1	#idle1 #endereco do perso q vou printar
	mv s1,	a0	#0xFF000000 #endereço do bitmap DISPLAY
	#la s0, idle1
	#li s1, 0xFF000000
	mv s6, s1
	li s2, 0 	# contador da linha
	li s5, 0		#contador da coluna
	lw s3, 0(s0) 	# largura da imagem
	li t1, 4
	div s3, s3, t1
	lw s4, 4(s0)	#altura da imagem
	addi s0, s0, 8
	#mul t0, s3, s4	# tamanho do vetor imagem
forIMP:
	bge s2, s4, fimIMP
	mv s5, zero
	j forColIMP
testeIMP:
	#done
	addi s2, s2, 1
	#li t3, 320
	#mul t3, t3, s2
	#add s6, s1, t3
	addi s1, s1, 320
	li t3, 4
	mul t3, t3, s3
	sub s1, s1, t3
	j forIMP
forColIMP:
	bge s5, s3, testeIMP
	lw t1, 0(s0)
	sw t1, 0(s1)
	addi s1, s1, 4
	addi s0, s0, 4
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
	addi sp, sp, -28
	ret
	
limpaJ:
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
	
	mv s0, 	a1	#idle1 #endereco do perso q vou printar
	mv s1,	a0	#0xFF000000 #endereço do bitmap DISPLAY
	#la s0, idle1
	#li s1, 0xFF000000
	mv s6, s1
	li s2, 0 	# contador da linha
	li s5, 0		#contador da coluna
	lw s3, 0(s0) 	# largura da imagem
	li t1, 4
	div s3, s3, t1
	lw s4, 4(s0)	#altura da imagem
	li t1, 0x00000000	#escolhe a cor ou o fundo q vai cobrir
	#mul t0, s3, s4	# tamanho do vetor imagem
forLIMP:
	bge s2, s4, fimLIMP
	mv s5, zero
	j forColLIMP
testeLIMP:
	#done
	addi s2, s2, 1
	#li t3, 320
	#mul t3, t3, s2
	#add s6, s1, t3
	addi s1, s1, 320
	li t3, 4
	mul t3, t3, s3
	sub s1, s1, t3
	j forLIMP
forColLIMP:
	bge s5, s3, testeLIMP
	#lw t1, 0(s0)
	sw t1, 0(s1)
	addi s1, s1, 4
	#addi s0, s0, 4
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
	addi sp, sp, -28
	ret
