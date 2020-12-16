.text

BOX_COLLIDER:
	# a0 eh a pos do jogador 
	# a1 eh a pos do oponente
	# a2 ver tamanho do sprite
	
	lw t0, 0(a2)
	add t0, a0, t0		# ajustar de acordo com o tamanho da imagem
	bgt t0, a1, HITOU
	li a0, 0
	ret
HITOU:
	li a0, 1
	ret
	
REDUZ_VIDA:
	la t0, vida
	lw t1, 0(t0)
	addi t1, t1, -1
	sw t1, 0(t0)
	ret

# recebe como argumento a quantidade de vida em numero
QUAL_VIDA:
	li t0, 5
	rem a0, a0, t0 
	li t0, 4
	bne a0, t0, PROX1COR
	la a0, coracaoCheio
	ret
PROX1COR:
	li t0, 3
	bne a0, t0, PROX2COR
	la a0, coracao2
	ret
PROX2COR:
	li t0, 2
	bne a0, t0, PROX3COR
	la a0, coracao3
	ret
PROX3COR:
	li t0, 1
	bne a0, t0, PROX4COR
	la a0, coracao4
	ret
PROX4COR:
	la a0, coracao5
PROX5COR:
	ret

# printa varios coracoes

PRINT_VIDA:
	addi sp, sp, -4
	sw ra, 0(sp)
	la t0, vida
	lw t1, 0(t0)
	li t2, 5
	div t1, t1, t2
	blez t1, END_GAME
	li t2, 0
FOR_VIDA:
	lw t3, 4(t0)
	li t4, 20
	mul t4, t4, t2
	add t3, t3, t4
	mv a0, t3
	la a1, coracaoCheio
	addi sp, sp, -12
	sw t1, 0(sp)
	sw t2, 4(sp)
	sw t0, 8(sp)
	jal imprimeJ
	lw t1, 0(sp)
	lw t2, 4(sp)
	lw t0, 8(sp)
	addi sp, sp, 8
	addi t2, t2, 1
	blt t2, t1, FOR_VIDA
	
	la a0, vida
	lw a0, 0(a0)
	jal QUAL_VIDA
	mv a1, a0
	
	la t0, vida
	lw t1, 0(t0)
	li t2, 5
	div t1, t1, t2
	
	lw a0, 4(t0)
	li t4, 20
	mul t4, t4, t1
	add a0, a0, t4
	jal imprimeJ			# a1 = sprite pra printar a0 = pos

	la t0, vida
	lw t1, 0(t0)
	li t2, 5
	div t1, t1, t2
	addi t2, t1, 1
	li t5, 5
FOR_VIDA_VAZIA:	
	bge t2, t5, SAI_FORA_VIDA
	lw t3, 4(t0)
	li t4, 20
	mul t4, t4, t2
	add t3, t3, t4
	mv a0, t3
	la a1, coracao5
	addi sp, sp, -8
	sw t1, 0(sp)
	sw t2, 4(sp)
	jal imprimeJ
	lw t1, 0(sp)
	lw t2, 4(sp)
	addi sp, sp, 8
	addi t2, t2, 1
	j FOR_VIDA_VAZIA

SAI_FORA_VIDA:
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
# manda o numero e ele devolve o sprite do numero
ESCOLHE_NUMERO:
	li t0, 0
	bne a0, t0, PROX0NUM
	la a0, NUM0
	ret
PROX0NUM:
	li t0, 1
	bne a0, t0, PROX1NUM
	la a0, NUM1
	ret
PROX1NUM:
	li t0, 2
	bne a0, t0, PROX2NUM
	la a0, NUM2
	ret
PROX2NUM:
	li t0, 3
	bne a0, t0, PROX3NUM
	la a0, NUM3
	ret
PROX3NUM:
	li t0, 4
	bne a0, t0, PROX4NUM
	la a0, NUM4
	ret
PROX4NUM:
	li t0, 5
	bne a0, t0, PROX5NUM
	la a0, NUM5
	ret
PROX5NUM:
	li t0, 6
	bne a0, t0, PROX6NUM
	la a0, NUM6
	ret
PROX6NUM:
	li t0, 7
	bne a0, t0, PROX7NUM
	la a0, NUM7
	ret
PROX7NUM:
	li t0, 8
	bne a0, t0, PROX8NUM
	la a0, NUM8
	ret
PROX8NUM:
	li t0, 9
	bne a0, t0, PROX9NUM
	la a0, NUM9
PROX9NUM:
	ret