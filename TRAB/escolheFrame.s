.text

ESCOLHEFRAME:
	la t0, frameToShow	# Trocamos de frame
	la t2, framePtr		# Ptr para o frame q sera desenhado
	lbu t1, 0(t0)
	xori t1, t1, 1		# Inverter o bit
	sb t1, 0(t0)		# Guarda o valor em frameToShow
	li t0, VGAFRAMESELECT	# pega o end q escolhe qual frame
	sb t1, 0(t0)
	li t3, VGAADDRESSINI0	# Escolhe o 0
	li t4, VGAADDRESSFIM0
	li t5, VGAADDRESSINI1		# Escolhe frame 1
	li t6, VGAADDRESSFIM1
	
	#li t5, 0
	beq t1, zero, Render.selectF0	# Mas eh realmente o frame 0?
	li t3, VGAADDRESSINI1		# Escolhe frame 1
	li t4, VGAADDRESSFIM1
	li t5, VGAADDRESSINI0	# Escolhe o 0
	li t6, VGAADDRESSFIM0
	#li t5, 1
Render.selectF0:
	sw t3, 0(t2)			# Salvar em framePtr
	sw t4, 4(t2)
	sw t5, 8(t2)
	sw t6, 12(t2)
	
	ret	
	
TROCAFRAME:
	la t0, frameToShow	# Trocamos de frame
	lbu t1, 0(t0)
	xori t1, t1, 1		# Inverter o bit
	sb t1, 0(t0)		# Guarda o valor em frameToShow
	
	li t0, VGAFRAMESELECT
	#la t1, frameToShow
	lw t1, 0(t1)
	sw t1, 0(t0)
	ret
