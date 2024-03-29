.data

.global main

# .equ <nome> <valor hex>
# Este bloco armazena os valores, em hexadecimal

.equ L, 0x4C
.equ E, 0x45
.equ D, 0x44
.equ Um, 0x41
.equ Dois, 0x42
.equ Tres, 0x43
.equ Quatro, 0x44
.equ Cinco, 0x45

.equ O, 0x4F
.equ P, 0x50
.equ C, 0x43
.equ A, 0x41
.equ O, 0x4F


.equ clear, 0x01 # comando para limpar o display
.equ space, 0x20


.equ virgula, 0x2C
.equ aspas, 0x22
.equ treze, 13
.equ dez, 10
.equ publish, 0x30
.equ remain_bytes, 0x0D
.equ msb, 0x00
.equ lsb, 0x07



at1: .ascii "AT"

at2: .ascii "AT+RST"

at3: .ascii "AT+CWMODE_CUR=1"

at4: .ascii "AT+CIPMUX=0"

at5: .ascii "AT+CWJAP_CUR="
at5_p1: .ascii "ABCDEABCD"
at5_p2: .ascii "HelloWorldMP31"

at6: .ascii "AT+CIPSTART="
at6_p1: .ascii "TCP"
at6_p2: .ascii "192.168.43.39"
at6_p3: .ascii "1883"

at7: .ascii "AT+CIPSEND=15"
at8: .ascii "AT+CIPSEND=17"
topico: .ascii "SDTopic"


.text


# custom <id da instrução> <result> <dataA> <dataB>

# Nesta label a instrução customizada é chamada com os parâmetros dos registradores r0 e r3
# Nesse caso r0 indica ao lcd que está sendo enviado um comando e r3 equivale ao comando a ser executado

main:

	addi r14, r0, 1 

	movia r5, 0x3030   # endereço de memórios dos botões
	movia r6, 0x3020   # endereço de memória das colunas
	movia r13, 0x2010  # endereço de memória das linhas
	movia r15, 0x2030  # endereço de memória da uart

init_lcd:
	movia r3, 0x30
	custom 0, r2, r0, r3
	custom 0, r2, r0, r3

	movia r3, 0x39
	custom 0, r2, r0, r3

	movia r3, 0x14
	custom 0, r2, r0, r3

	movia r3, 0x56
	custom 0, r2, r0, r3

	movia r3, 0x6D
	custom 0, r2, r0, r3

	movia r3, 0x70
	custom 0, r2, r0, r3

	movia r3, 0x0C
	custom 0, r2, r0, r3

	movia r3, 0x06
	custom 0, r2, r0, r3

	movia r3, 0x01
	custom 0, r2, r0, r3
	
	# br led1

send_AT:
	movia r11, 0x41
	stwio r11, 0(r15)
	custom 0, r2, r14, r11

	movia r11, 0x54
	stwio r11, 0(r15)
	custom 0, r2, r14, r11

	movia r11, 0x0D
	stwio r11, 0(r15)

	movia r11, 0x0A
	stwio r11, 0(r15)	

	addi r10, r0, 0
	movia r11, 1000000
	call delay
	movia r3, clear # Limpa o display
	custom 0, r2, r0, r3

send_AT_RST:
    movia r11, 0x41
	stwio r11, 0(r15)
	custom 0, r2, r14, r11

	movia r11, 0x54
	stwio r11, 0(r15)
	custom 0, r2, r14, r11

	movia r11, 0x2B
	stwio r11, 0(r15)
	custom 0, r2, r14, r11

	movia r11, 0x52
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	

	movia r11, 0x53
	stwio r11, 0(r15)
	custom 0, r2, r14, r11

	movia r11, 0x54
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	

	movia r11, 0x0D
	stwio r11, 0(r15)

	movia r11, 0x0A
	stwio r11, 0(r15)	

	addi r10, r0, 0
	movia r11, 1000000
	call delay
	movia r3, clear # Limpa o display
	custom 0, r2, r0, r3	

send_AT_CIPMUX:
	movia r11, 0x41
	stwio r11, 0(r15)
	custom 0, r2, r14, r11

	movia r11, 0x54
	stwio r11, 0(r15)
	custom 0, r2, r14, r11

	movia r11, 0x2B
	stwio r11, 0(r15)
	custom 0, r2, r14, r11

	movia r11, 0x43
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	

	movia r11, 0x49
	stwio r11, 0(r15)
	custom 0, r2, r14, r11

	movia r11, 0x50
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	

	movia r11, 0x4D
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	

	movia r11, 0x55
	stwio r11, 0(r15)
	custom 0, r2, r14, r11

	movia r11, 0x58
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	

	movia r11, 0x3D
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	

	movia r11, 0x30
	stwio r11, 0(r15)
	custom 0, r2, r14, r11

	movia r11, 0x0D
	stwio r11, 0(r15)

	movia r11, 0x0A
	stwio r11, 0(r15)	

	addi r10, r0, 0
	movia r11, 1000000
	call delay
	movia r3, clear # Limpa o display
	custom 0, r2, r0, r3

send_AT_CWJAP:
	movia r11, 0x41
	stwio r11, 0(r15)
	custom 0, r2, r14, r11

	movia r11, 0x54
	stwio r11, 0(r15)
	custom 0, r2, r14, r11

	movia r11, 0x2B
	stwio r11, 0(r15)
	custom 0, r2, r14, r11

	movia r11, 0x43
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	

	movia r11, 0x57
	stwio r11, 0(r15)
	custom 0, r2, r14, r11

	movia r11, 0x4A
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	

	movia r11, 0x41
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	

	movia r11, 0x50
	stwio r11, 0(r15)
	custom 0, r2, r14, r11

	movia r11, 0x3D
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	
	movia r11, aspas
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	

	movia r11, 0x41
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	

	movia r11, 0x42
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	

	movia r11, 0x43
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	

	movia r11, aspas
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	

	movia r11, virgula
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	

	movia r11, aspas
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	

	movia r11, Um
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	

	movia r11, Dois
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	

	movia r11, Um
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	

	movia r11, Dois
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	

	movia r11, Um
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	

	movia r11, Dois
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	

	movia r11, Um
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	

	movia r11, Dois
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	

	movia r11, aspas
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	

	movia r11, 0x0D
	stwio r11, 0(r15)

	movia r11, 0x0A
	stwio r11, 0(r15)	

	addi r10, r0, 0
	movia r11, 1000000
	call delay
	movia r3, clear # Limpa o display
	custom 0, r2, r0, r3

init_mqtt:
	# FIDEX HEADER
	movia r11, 0x10 # CONNECT
	call write_uart

	movia r11, 0x0F # REMAING LENGTH
	# VARIABLE HEADER
	call write_uart	

	movia r11, 0x00 # MSB
	call write_uart	

	movia r11, 0x04 # LSB
	call write_uart	

	movia r11, 0x4D # M
	call write_uart	

	movia r11, 0x51 # Q
	call write_uart	

	movia r11, 0x54 # T
	call write_uart	

	movia r11, 0x54 # T
	call write_uart	

	movia r11, 0x04 # PROTOCOL LEVEL
	call write_uart	

	movia r11, 0x02 # FLAGS
	call write_uart	

	movia r11, 0x00 # KEEP ALIVE MSB
	call write_uart	

	movia r11, 0x0A # KEEP ALIVE LSB
	call write_uart	

	#PAYLOAD
	movia r11, 0x00 #MSB
	call write_uart	

	movia r11, 0x03 #LSB
	call write_uart	

	movia r11, 0x47 #G
	call write_uart	

	movia r11, 0x50 #P
	call write_uart	

	movia r11, 0x33 #3
	call write_uart	

	br led1

send_at8:
	movia r7, at8
	addi r10, r0, 13
	add r12, r0, r0
	movia r8, init_mqtt
	subi sp, sp, 8
	stw ra, 1(sp)
	call loop_write_uart_end2

send_at7:
	movia r7, at7
	addi r10, r0, 13
	add r12, r0, r0
	movia r8, send_mqtt
	subi sp, sp, 8
	stw ra, 1(sp)
	call loop_write_uart_end2

send_mqtt:
	movia r11, publish
	call write_uart	
	movia r11, remain_bytes
	call write_uart	
	movia r11, msb
	call write_uart	
	movia r11, lsb
	call write_uart	

	movia r7, topico
	addi r10, r0, 7
	add r12, r0, r0
	movia r8, send_mqtt2
	call loop_write_uart


send_mqtt2:
	movia r11, L
	call write_uart	
	movia r11, E
	call write_uart	
	movia r11, D
	call write_uart	
	add r11, r0, r4
	call write_uart	

	ldw ra, 1(sp)
	addi sp, sp, 8
	ret 

loop_write_uart:
	add r3, r7, r12
	ldb r11, 0(r3)
	call write_uart
	addi r12, r12, 1
	bgt r12, r10, loop_write_uart_next_destine
	br loop_write_uart	

loop_write_uart_end:
	add r3, r7, r12
	ldb r11, 0(r3)
	call write_uart	
	addi r12, r12, 1
	bgt r12, r10, loop_write_uart_next_destine_end
	br loop_write_uart_end

loop_write_uart_end2:
	add r3, r7, r12
	ldb r11, 0(r3)
	call write_uart	
	addi r12, r12, 1
	bgt r12, r10, loop_write_uart_next_destine_end2
	br loop_write_uart_end2

loop_write_uart_next_destine:
	callr r8

loop_write_uart_next_destine_end:
	movia r11, aspas
	call write_uart
	call end_command
	callr r8

loop_write_uart_next_destine_end2:
	call end_command
	callr r8

end_command:

	subi sp, sp, 8
	stw ra, 1(sp)

	movia r11, treze
	call write_uart	
	movia r11, dez
	call write_uart	

	addi r10, r0, 0
	movia r11, 1200
	call delay

	call read_from_uart
	custom 0, r2, r14, r3

	addi r10, r0, 0
	movia r11, 2000000
	call delay

	movia r3, clear # Limpa o display
	custom 0, r2, r0, r3

	ldw ra, 1(sp)
	addi sp, sp, 8
	ret

read_from_uart:
	ldwio r3, 0(r15)
	andi r7, r3, 0x8000
	bne r7, r0, read_from_uart_private
	mov r3, r0

read_from_uart_private:
	andi r7, r3, 0x00ff
	mov r3, r7
	ret

clear_uart:
	ldb r3, 0(r15)
	bne r3, r0, clear_uart
	ret

write_uart:
	subi sp, sp, 4
	stw ra, 0(sp)
	br write_uart_private

write_uart_private:
	ldwio r7, 4(r15)
	andhi r7, r7, 0x00ff
	beq r7, r0, write_uart_private
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	addi r10, r0, 0
	movia r11, 800000
	call delay
	movia r3, clear # Limpa o display
	custom 0, r2, r0, r3

	ldw ra, 0(sp)
	addi sp, sp, 4
	ret

# Nesta label a instrução customizada está sendo chamada novamente: 
# r14 indica que está sendo enviado um dado e r3 é o dado a ser escrito no display

	
menu_lcd:

	movi r7, 31
	stbio r7, 0(r6) # Apaga todas as colunas

	movi r7, 255
	stbio r7, 0(r13) 

	movia r3, clear # Limpa o display
	custom 0, r2, r0, r3
	
	movia r3, L
	custom 0, r2, r14, r3

	movia r3, E
	custom 0, r2, r14, r3
	
	movia r3, D
	custom 0, r2, r14, r3
	
	movia r3, space
	custom 0, r2, r14, r3
	
	custom 0, r2, r14, r4
	
	ret
	
led1:
	movia r4, Um
	
	call menu_lcd # atualiza o display
	
	nextpc r8 # pega o endereço da próxima instrução

	addi r10, r0, 0
	movia r7, 400000

	call delay #chama label delay 
	
	ldbuio r3, 0(r5) # carrega a situação dos botões

	addi r7, r0, 2
	beq r3, r7, frase_selection1 

	addi r7, r0, 4
	beq r3, r7, led2 
	
	addi r7, r0, 8
	beq r3, r7, led5 
	
	callr r8 

delay: # esta label executa um contador para criar um delay na execução

	addi r10, r10, 1
	ble r10, r7, delay

	ret


led2:
	movia r4, Dois
	
	call menu_lcd
	
	nextpc r8

	addi r10, r0, 0
	movia r7, 400000

	call delay

	ldbuio r3, 0(r5) 
	
	addi r7, r0, 2
	beq r3, r7, frase_selection2
	
	addi r7, r0, 4
	beq r3, r7, led3 
	
	addi r7, r0, 8
	beq r3, r7, led1 
	
	callr r8
	
led3:
	movia r4, Tres
	
	call menu_lcd 
	
	nextpc r8

	addi r10, r0, 0
	movia r7, 400000

	call delay

	ldbuio r3, 0(r5) 

	addi r7, r0, 2
	beq r3, r7, frase_selection3
	
	addi r7, r0, 4
	beq r3, r7, led4 
	
	addi r7, r0, 8
	beq r3, r7, led2

	callr r8
	
led4:
	movia r4, Quatro
	
	call menu_lcd 
	
	nextpc r8

	addi r10, r0, 0
	movia r7, 400000

	call delay

	ldbuio r3, 0(r5) 

	addi r7, r0, 2
	beq r3, r7, frase_selection4

	addi r7, r0, 4
	beq r3, r7, led5 
	
	addi r7, r0, 8
	beq r3, r7, led3 
	
	callr r8

led5:
	movia r4, Cinco
	
	call menu_lcd 
	nextpc r8

	addi r10, r0, 0
	movia r7, 400000

	call delay

	ldbuio r3, 0(r5) 

	addi r7, r0, 2
	beq r3, r7, frase_selection5
	
	addi r7, r0, 4
	beq r3, r7, led1 
	
	addi r7, r0, 8
	beq r3, r7, led4 

	callr r8
	
frase_selection1:

	addi r7, r0, 30
	stbio r7, 0(r6) # colunas

	stbio r0, 0(r13) # linhas

	movia r3, clear
	custom 0, r2, r0, r3
	
	movia r3, O
	custom 0, r2, r14, r3
	
	movia r3, P
	custom 0, r2, r14, r3

	movia r3, C
	custom 0, r2, r14, r3
	
	movia r3, A
	custom 0, r2, r14, r3

	movia r3, O
	custom 0, r2, r14, r3
	
	movia r3, space
	custom 0, r2, r14, r3
	
	movia r3, E
	custom 0, r2, r14, r3
	
	movia r3, space
	custom 0, r2, r14, r3
	
	movia r3, L
	custom 0, r2, r14, r3
	
	movia r3, E
	custom 0, r2, r14, r3
	
	movia r3, D
	custom 0, r2, r14, r3
	
	movia r3, space
	custom 0, r2, r14, r3
	
	movia r3, Um
	custom 0, r2, r14, r3
	
	nextpc r8 #  guarda o endereço da instrução de leitura dos botões
	
	ldbuio r3, 0(r5) # verifica os botões
	
	beq r3, r14, led1 
	
	callr r8 
	

frase_selection2:

	movi r7, 29
	stbio r7, 0(r6) # colunas

	stbio r0, 0(r13) # linhas

	movia r3, clear
	custom 0, r2, r0, r3
	
	movia r3, O
	custom 0, r2, r14, r3
	
	movia r3, P
	custom 0, r2, r14, r3

	movia r3, C
	custom 0, r2, r14, r3
	
	movia r3, A
	custom 0, r2, r14, r3

	movia r3, O
	custom 0, r2, r14, r3
	
	movia r3, space
	custom 0, r2, r14, r3
	
	movia r3, E
	custom 0, r2, r14, r3
	
	movia r3, space
	custom 0, r2, r14, r3
	
	movia r3, L
	custom 0, r2, r14, r3
	
	movia r3, E
	custom 0, r2, r14, r3
	
	movia r3, D
	custom 0, r2, r14, r3
	
	movia r3, space
	custom 0, r2, r14, r3
	
	movia r3, Dois
	custom 0, r2, r14, r3
	
	nextpc r8
	
	ldbuio r3, 0(r5)
	
	beq r3, r14, led2
	
	callr r8
	
	
frase_selection3:

	movi r7, 27
	stbio r7, 0(r6) # colunas

	stbio r0, 0(r13) # linhas

	movia r3, clear
	custom 0, r2, r0, r3
	
	movia r3, O
	custom 0, r2, r14, r3
	
	movia r3, P
	custom 0, r2, r14, r3

	movia r3, C
	custom 0, r2, r14, r3
	
	movia r3, A
	custom 0, r2, r14, r3

	movia r3, O
	custom 0, r2, r14, r3
	
	movia r3, space
	custom 0, r2, r14, r3
	
	movia r3, E
	custom 0, r2, r14, r3
	
	movia r3, space
	custom 0, r2, r14, r3
	
	movia r3, L
	custom 0, r2, r14, r3
	
	movia r3, E
	custom 0, r2, r14, r3
	
	movia r3, D
	custom 0, r2, r14, r3
	
	movia r3, space
	custom 0, r2, r14, r3
	
	movia r3, Tres
	custom 0, r2, r14, r3
	
	nextpc r8
	
	ldbuio r3, 0(r5)
	
	beq r3, r14, led3
	
	callr r8
	
	
frase_selection4:

	movi r7, 23
	stbio r7, 0(r6) # colunas

	stbio r0, 0(r13) # linhas

	movia r3, clear
	custom 0, r2, r0, r3
	
	movia r3, O
	custom 0, r2, r14, r3
	
	movia r3, P
	custom 0, r2, r14, r3

	movia r3, C
	custom 0, r2, r14, r3
	
	movia r3, A
	custom 0, r2, r14, r3

	movia r3, O
	custom 0, r2, r14, r3
	
	movia r3, space
	custom 0, r2, r14, r3
	
	movia r3, E
	custom 0, r2, r14, r3
	
	movia r3, space
	custom 0, r2, r14, r3
	
	movia r3, L
	custom 0, r2, r14, r3
	
	movia r3, E
	custom 0, r2, r14, r3
	
	movia r3, D
	custom 0, r2, r14, r3
	
	movia r3, space
	custom 0, r2, r14, r3
	
	movia r3, Quatro
	custom 0, r2, r14, r3
	
	nextpc r8
	
	ldbuio r3, 0(r5)
	
	beq r3, r14, led4
	
	callr r8
	
	
frase_selection5:

	movi r7, 15
	stbio r7, 0(r6) # colunas

	stbio r0, 0(r13) # linhas

	movia r3, clear
	custom 0, r2, r0, r3
	
	movia r3, O
	custom 0, r2, r14, r3
	
	movia r3, P
	custom 0, r2, r14, r3

	movia r3, C
	custom 0, r2, r14, r3
	
	movia r3, A
	custom 0, r2, r14, r3

	movia r3, O
	custom 0, r2, r14, r3
	
	movia r3, space
	custom 0, r2, r14, r3
	
	movia r3, E
	custom 0, r2, r14, r3
	
	movia r3, space
	custom 0, r2, r14, r3
	
	movia r3, L
	custom 0, r2, r14, r3
	
	movia r3, E
	custom 0, r2, r14, r3
	
	movia r3, D
	custom 0, r2, r14, r3
	
	movia r3, space
	custom 0, r2, r14, r3
	
	movia r3, Cinco
	custom 0, r2, r14, r3
	
	nextpc r8
	
	ldbuio r3, 0(r5)
	
	beq r3, r14, led5
	
	callr r8