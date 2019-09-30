
#codigo  em assembly   do Jogo Pong 

.global main

#usado para instrução no lcd
.macro instr db
	custom 1, r0, r0, \db
.endm

#usado para dados no lcd
.macro data db
	movi r1, 1
	custom 1, r0, r1, \db
.endm

.equ START, 0x50a0
.equ P1X, 0x5090
.equ P1Y, 0x5080
.equ P2X, 0x5070
.equ P2Y, 0x5060
.equ BX, 0x5050
.equ BY, 0x5040
.equ Jogador1, 0x5030
.equ Jogador2, 0x5020
.equ RND, 0x5000

#Reseta a posição da bola
#Inicializa o lcd
#Cria o menu na lcd
#Inicializa alguns registradores

main:
	call resetBall
	call init
	call menu
	movia r11, START
	movi r7, 3       # velocidade em x
	movi r8, 3       # velicodade em y
	mov r9, r0       # pontuação do jogador 1
	mov r10, r0      # pontuação do jogador 2
# Ficar no aguardo do usuario  clicar no botão  start 

wait:
	ldwio r2, 0(r11)
	beq r2, r0, wait
	movi r2, 1
	instr r2	
	call placar

# a função a seguir ficar  no Loop  de funcionamento do jogo.
# realizando todas as funções necessaria para que jogo 
# funcione corretamente incluido os tratamento de colisões
#e as movimentações da bola e barras.
gameLoop:
	call moverBarra
	call moveBall
	call PlayersCollision
	call wallCollision
	custom 3, r1, r1, r1
	br gameLoop

#examina se a bola chegou no x da barra1 e barra2, dependendo entra no verificarBarra1 ou verificarBarra2
PlayersCollision:
	movi r1, 610 # X da barra 2
	mov r2, r5   # X da bola
	addi r2, r2, 4
	bge r2, r1, verificarBarra2
	movi r1, 20
	subi r2, r2, 8
	bge r1, r2, verificarBarra1
	ret

#Realiza a  conversão do valor pego pelo potenciometro 
#para o y da tela e assim retorna a colisão ou nao
verificarBarra2:
	movia r13, Jogador2
	movi r14, -1
	ldwio r1, 0(r13)
	addi r1, r1, 1
	movi r3, 4
	custom 0, r1, r1, r3
	movi r3, 6
	custom 2, r1, r1, r3
	addi r1, r1, 7
	mov r2, r6
	bge r2, r1, tamanhoBarra2
	ret

#realizar o mesmo procedimento que a função acima
verificarBarra1:
	movia r13, Jogador1
	ldwio r1, 0(r13)
	movi r14, 1
	addi r1, r1, 1
	movi r3, 4
	custom 0, r1, r1, r3
	movi r3, 6
	custom 2, r1, r1, r3
	addi r1, r1, 7
	mov r2, r6
	bge r2, r1, tamanhoBarra1
	ret

#Examina se ao colidir com a barra Dependendo da posição
# entra em um  dos hit diferente
tamanhoBarra2:
	addi r1, r1, 16
	bge r1, r2, hit1
	addi r1, r1, 16
	bge r1, r2, hit2
	addi r1, r1, 16
	bge r1, r2, hit3
	addi r1, r1, 16
	bge r1, r2, hit4
	addi r1, r1, 16
	bge r1, r2, hit5
	ret

# Verificar  se ao colidir com a barra Dependendo da posição
#entra em um hit diferente
tamanhoBarra1:
	addi r1, r1, 16
	bge r1, r2, _hit1
	addi r1, r1, 16
	bge r1, r2, _hit2
	addi r1, r1, 16
	bge r1, r2, _hit3
	addi r1, r1, 16
	bge r1, r2, _hit4
	addi r1, r1, 16
	bge r1, r2, _hit5
	ret

#HIT BARRA DIREITA
hit1:
    movia r14, RND
	ldwio r1, 0(r14)
	mov r2, r0
	beq r1, r2, zero
	addi r2,r2,1
	beq r1, r2, um
	addi r2,r2,1
	beq r1, r2, dois
	addi r2,r2,1
	beq r1, r2, tres
	ret
hit2:
    movi r7, -3
    movi r8, -3
	ret
hit3:
    movi r8, 0
    movi r7, -3
        ret 
hit4:
    movi r7, -3
    movi r8, 3
	ret
hit5:
	movia r14, RND
	ldwio r1, 0(r14)
	mov r2, r0
	beq r1, r2, zero
	addi r2,r2,1
	beq r1, r2, um
	addi r2,r2,1
	beq r1, r2, dois
	addi r2,r2,1
	beq r1, r2, tres
	ret

#HIT BARRA DIREITA
_hit1:
    movia r14, RND
	ldwio r1, 0(r14)
	mov r2, r0
	beq r1, r2, _zero
	addi r2,r2,1
	beq r1, r2, _um
	addi r2,r2,1
	beq r1, r2, _dois
	addi r2,r2,1
	beq r1, r2, _tres
	ret
_hit2:
    movi r7, 3
    movi r8, -3
	ret
_hit3:
    movi r8, 0
    movi r7, 3
	ret 
_hit4:
    movi r7, 3
    movi r8, 3
	ret
_hit5:
	movia r14, RND
	ldwio r1, 0(r14)
	mov r2, r0
	beq r1, r2, _zero
	addi r2,r2,1
	beq r1, r2, _um
	addi r2,r2,1
	beq r1, r2, _dois
	addi r2,r2,1
	beq r1, r2, _tres
	ret

#movimentação ir  pra esquerda
zero:
	movi r8, 0
	movi r7, -3
	ret
um:
	movi r7, -3
	movi r8, -3
	ret
dois:
	movi r7, -1
	movi r8, -3
	ret
tres:
	movi r7, -3
	movi r8, -1
	ret

#movimentação ir para direita
_zero:
	movi r8, 0
	movi r7, 3
	ret
_um:
	movi r7, 3
	movi r8, 3
	ret
_dois:
	movi r7, 1
	movi r8, 3
	ret
_tres:
	movi r7, 3
	movi r8, 1
	ret

#Examina  se ao realizar uma colisão em qualquer parte do wall
#entra em uma partes diferentes
wallCollision:
	movi r1, 471
	mov r2, r6
	addi r2,r2,4
	bge r2, r1, changeDownWall
	movi r1, 625
	mov r2, r5
	addi r2, r2, 4
	bge r2, r1, changeRightWall
	movi r1, 8
	mov r2, r6
	subi r2, r2, 4
	bge r1, r2, changeDownWall
	movi r1, 8
	mov r2, r5
	subi r2, r2, 4
	bge r1, r2, changeLeftWall
	ret

# A função a seguir verificar a pontuação atingida pello jogadores
# para questões de teste estimulamos uma pontuação maxima de 5 pontos
# para decidir quem ganhou 
changeRightWall:
	addi r9, r9, 1
	movi r1, 5
	beq r1, r9, win1
	addi r3, r9, 48
	movi r1, 0x8a
	instr r1
	data r3
	movi r7, 3
	mov r8, r7
	br resetBall

changeLeftWall:
	addi r10, r10, 1
	movi r1, 5
	beq r1, r10, win2
	addi r3, r10, 48
	movi r1, 0xca
	instr r1
	data r3
	movi r7, 3
	mov r8, r7
	br resetBall

#Verificar  se ao bater na wall de cima ou baixo
#retorna no mesmo angulo de entrada
changeDownWall:
	movi r1, -1
	custom 2, r8,r8,r1
	ret

#emite  para o módulo VGA a posição em que deve-se
#desenhar a bola
moveBall:
	add r5,r5,r7
	add r6,r6,r8
	movia r12, BX
	stwio r5, 0(r12)
	movia r12, BY
	stwio r6, 0(r12)
	ret
	
#Realiza a movimentação da barra
#de acordo com o posicionamento do 
#potenciometro, após isso envia para o módulo VGA
#a posição da barra para o mesmo desenhar na tela
moverBarra:
	# pos = valor do potenciometro: 0-255
	# pos = (pos + 1)/4;
	# pos = (pos*6) + 7;
	movia r12, Jogador1
	movia r13, Jogador2
	ldwio r1, 0(r12)
	ldwio r2, 0,(r13)
	addi r1, r1, 1
	addi r2, r2, 1
	movi r3, 4
	custom 0, r1, r1, r3
	custom 0, r2, r2, r3	
	movi r3, 6
	custom 2, r1, r1, r3
	custom 2, r2, r2, r3	
	addi r1, r1, 7
	addi r2, r2, 7

	movi r3, 10
	movia r12, P1X
	stwio r3, 0(r12)
	movia r12, P1Y
	stwio r1, 0(r12)
	
	movia r3, 610
	movia r12, P2X
	stwio r3, 0(r12)
	movia r12, P2Y
	stwio r2, 0(r12)
	ret

#Reseta a posição da bola
#centralizando a mesma 
#limpa o posicionamento das barras 

resetBall:
	movia r12, BX
	movi r1, 316
	stwio r1, 0(r12)
	movia r12, BY
	movi r1, 236
	stwio r1, 0(r12)
	movi r5, 316 # X da bola
	movi r6, 236 # Y da bola	
	ret

#Escreve no lcd a vitória do jogador 1
win1:
	movi r2, 0x1
	instr r2
	movi r2, 0x84
	instr r2
	
	movi r2, 0x4a #J
 	data r2
	movi r2, 0x6f #o
 	data r2
	movi r2, 0x67 #g
 	data r2
	movi r2, 0x61 #a
 	data r2
	movi r2, 0x64 #d
 	data r2
	movi r2, 0x6f #o
 	data r2
	movi r2, 0x72 #r
 	data r2
	movi r2, 0x20 # 
 	data r2
	movi r2, 0x31 #1
 	data r2

	movi r2, 0xc5
	instr r2
	movi r2, 0x47 #G
 	data r2
	movi r2, 0x61 #a
 	data r2
	movi r2, 0x6e #n
 	data r2
	movi r2, 0x68 #h
 	data r2
	movi r2, 0x6f #o
 	data r2
	movi r2, 0x75 #u
 	data r2
	movia r11, START
	br gameOver

#escreve no lcd a vitoria do jogador 2
win2:
	movi r2, 0x1
	instr r2
	movi r2, 0x84
	instr r2
	
	movi r2, 0x4a #J
 	data r2
	movi r2, 0x6f #o
 	data r2
	movi r2, 0x67 #g
 	data r2
	movi r2, 0x61 #a
 	data r2
	movi r2, 0x64 #d
 	data r2
	movi r2, 0x6f #o
 	data r2
	movi r2, 0x72 #r
 	data r2
	movi r2, 0x20 # 
 	data r2
	movi r2, 0x32 #2
 	data r2

	movi r2, 0xc5
	instr r2
	movi r2, 0x47 #G
 	data r2
	movi r2, 0x61 #a
 	data r2
	movi r2, 0x6e #n
 	data r2
	movi r2, 0x68 #h
 	data r2
	movi r2, 0x6f #o
 	data r2
	movi r2, 0x75 #u
 	data r2
	movia r11, START
	br gameOver

#ficar na espera do usuario apertar o botao de start para começar o jogo novamente
gameOver:
	ldwio r2, 0(r11)
	beq r2, r0, gameOver
	movi r2, 1
	instr r2
	call menu
	custom 3, r1,r1,r1
	custom 3, r1,r1,r1
	custom 3, r1,r1,r1
	custom 3, r1,r1,r1
	custom 3, r1,r1,r1
	custom 3, r1,r1,r1
	custom 3, r1,r1,r1
	custom 3, r1,r1,r1
	custom 3, r1,r1,r1
	custom 3, r1,r1,r1
	custom 3, r1,r1,r1
	custom 3, r1,r1,r1
	custom 3, r1,r1,r1
	custom 3, r1,r1,r1
	custom 3, r1,r1,r1
	custom 3, r1,r1,r1
	custom 3, r1,r1,r1
	custom 3, r1,r1,r1
	custom 3, r1,r1,r1
	custom 3, r1,r1,r1
	custom 3, r1,r1,r1
	call resetBall
	movi r7, 3    # velocidade em x
	movi r8, 3    # velicodade em y
	mov r9, r0    # pontuação do jogador 1
	mov r10, r0   # pontuação do jogador 2
	br wait


#Inicialização o do display lcd  
# Código  a seguir  que foi utilizado  se encontrar no seguinte endereço
# https://github.com/alysondantas/sd_pbl_um 

init:
	movi r2, 0x30
	instr r2
	
	movi r2, 0x30
	instr r2
	
	movi r2, 0x39
	instr r2
	
	movi r2, 0x14
	instr r2
	
	movi r2, 0x56
	instr r2

	movi r2, 0x6d
	instr r2

	movi r2, 0x0c
	instr r2

	movi r2, 0x06
	instr r2
	
	movi r2, 0x01
	instr r2

	ret

#Exibindo o placar do jogo  no display
placar:
	movi r2, 0x80
	instr r2 
	movi r2, 0x4a #J
 	data r2
	movi r2, 0x6f #o
 	data r2
	movi r2, 0x67 #g
 	data r2
	movi r2, 0x61 #a
 	data r2
	movi r2, 0x64 #d
 	data r2
	movi r2, 0x6f #o
 	data r2
	movi r2, 0x72 #r
 	data r2
	movi r2, 0x20 # 
 	data r2
	movi r2, 0x31 #1
 	data r2
	movi r2, 0x3a #:
 	data r2
	movi r2, 0x30 #0
 	data r2
	
	movi r2, 0xc0
	instr r2 
	movi r2, 0x4a #J
 	data r2
	movi r2, 0x6f #o
 	data r2
	movi r2, 0x67 #g
 	data r2
	movi r2, 0x61 #a
 	data r2
	movi r2, 0x64 #d
 	data r2
	movi r2, 0x6f #o
 	data r2
	movi r2, 0x72 #r
 	data r2
	movi r2, 0x20 # 
 	data r2
	movi r2, 0x32 #2
 	data r2
	movi r2, 0x3a #:
 	data r2
	movi r2, 0x30 #0
 	data r2
	ret

#mostar o menu  para  usuario no lcd
menu:
	movi r2, 0x1
	instr r2
	movi r2, 0x84
	instr r2
	movi r2, 0x50 #P
 	data r2
	movi r2, 0x6f #o
 	data r2
	movi r2, 0x6e #n
 	data r2
	movi r2, 0x67 #g
 	data r2
	movi r2, 0x20 #
 	data r2
	movi r2, 0x47 #G
 	data r2
	movi r2, 0x61 #a
 	data r2
	movi r2, 0x6d #m
 	data r2
	movi r2, 0x65 #e
 	data r2

	movi r2, 0xc3
	instr r2
	movi r2, 0x50 #P
 	data r2
	movi r2, 0x72 #r
 	data r2
	movi r2, 0x65 #e
 	data r2
	movi r2, 0x73 #s
 	data r2
	movi r2, 0x73 #s
 	data r2
	movi r2, 0x20 # 
 	data r2
	movi r2, 0x53 #S
 	data r2
	movi r2, 0x74 #t
 	data r2
	movi r2, 0x61 #a
 	data r2
	movi r2, 0x72 #r
 	data r2
	movi r2, 0x74 #t
 	data r2
	ret

end:
	br end
	.end