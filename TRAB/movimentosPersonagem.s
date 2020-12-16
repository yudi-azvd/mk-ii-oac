.eqv CHUTE_TIME 100

.text

ESQUERDA_P:
	addi t0, s2, -4
	li t1, 41600
	blt t0, t1, FIM_BEQ
	addi s2, s2, -4
	jal trocaSprite
	mv a1, s2
	jal RENDER_PLAYER
	li a0, 35
	jal ESPERA_AI
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
	jal trocaSprite
	mv a1, s2
	jal RENDER_PLAYER
	li a0, 35
	jal ESPERA_AI
	addi a0, s2, -4
	jal LIMPA_PMAIN
	j FIM_BEQ

ABAIXA_P:
	li t0, 320
	li t1, 24
	mul t0, t0, t1
	add a1, s2, t0
	la a0, abaixar2
	jal RENDER_PLAYER
	li a0, 300
	jal ESPERA_AI
	mv a0, s2
	jal LIMPA_PMAIN
	j FIM_BEQ

# AQUI FAZER A VERIFICACAO DE BOX COLLIDER
SOCO_P:
	la a0, punch_1
	mv a1, s2
	jal RENDER_PLAYER
	li a0, 150
	jal ESPERA_AI
	mv a0, s2
	jal LIMPA_PMAIN
	la a0, punch_2
	mv a1, s2
	jal RENDER_PLAYER
	li a0, 150
	jal ESPERA_AI
	mv a0, s2
	jal LIMPA_PMAIN
	la a0, punch_3
	mv a1, s2
	jal RENDER_PLAYER
	li a0, 150
	jal ESPERA_AI
	# teste boxcollider aqui
	la a2, idle1
	mv a0, s2
	la t0, enemy_pos
	lw a1, 0(t0)
	jal BOX_COLLIDER
	li t0, 1
	bne t0, a0, PULA_SOCO 
	jal REDUZ_VIDA
	# fim teste box collider
PULA_SOCO:
	mv a0, s2
	jal LIMPA_PMAIN
	la a0, punch_2
	mv a1, s2
	jal RENDER_PLAYER
	li a0, 150
	jal ESPERA_AI
	mv a0, s2
	jal LIMPA_PMAIN
	la a0, punch_1
	mv a1, s2
	jal RENDER_PLAYER
	li a0, 150
	jal ESPERA_AI
	mv a0, s2
	jal LIMPA_PMAIN
	j FIM_BEQ
	
# AQUI FAZER A VERIFICACAO DE BOX COLLIDER
CHUTE_P:
	la a0, chute1
	mv a1, s2
	jal RENDER_PLAYER
	li a0, CHUTE_TIME
	jal ESPERA_AI
	mv a0, s2
	jal LIMPA_PMAIN
	la a0, chute2
	mv a1, s2
	jal RENDER_PLAYER
	li a0, CHUTE_TIME
	jal ESPERA_AI
	mv a0, s2
	jal LIMPA_PMAIN
	la a0, chute3
	mv a1, s2
	jal RENDER_PLAYER
	li a0, CHUTE_TIME
	jal ESPERA_AI
	mv a0, s2
	jal LIMPA_PMAIN
	la a0, chute4
	mv a1, s2
	jal RENDER_PLAYER
	# teste boxcollider aqui
	mv a0, s2
	la t0, enemy_pos
	lw a1, 0(t0)
	la a2, chute4
	jal BOX_COLLIDER
	li t0, 1
	bne t0, a0, PULA_CHUTE 
	jal REDUZ_VIDA
	# fim teste box collider
PULA_CHUTE:
	li a0, CHUTE_TIME
	jal ESPERA_AI
	mv a0, s2
	jal LIMPA_PMAIN
	la a0, chute3
	mv a1, s2
	jal RENDER_PLAYER
	li a0, CHUTE_TIME
	jal ESPERA_AI
	mv a0, s2
	jal LIMPA_PMAIN
	la a0, chute2
	mv a1, s2
	jal RENDER_PLAYER
	li a0, CHUTE_TIME
	jal ESPERA_AI
	mv a0, s2
	jal LIMPA_PMAIN
	la a0, chute1
	mv a1, s2
	jal RENDER_PLAYER
	li a0, CHUTE_TIME
	jal ESPERA_AI
	mv a0, s2
	jal LIMPA_PMAIN
	j FIM_BEQ

	
