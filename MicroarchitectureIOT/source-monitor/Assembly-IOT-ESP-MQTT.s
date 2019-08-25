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

# seguir está chamada para funções que invocar  os metodos que usando protocolo no MQTT 
# para inicializar e  estabilizar a comunicação entre o esp e broker   

# Utilizamos a linguagem de comando At que se encontrar nos sites a seguir:
#  https://eduardoaw.github.io/2015-12-20-ESP-8266-Primeiros-Passos/
#  https://room-15.github.io/blog/2015/03/26/esp8266-at-command-reference/#


at1: .ascii "AT" # chamada para  a função onde está o metodo que o usar linguagem de comandos At  para  star a comunicação 

at2: .ascii "AT+RST" # chamada para chamada para  a função onde está o metodo que o usar linguagem de comandos At para resetar a comunicação limpando assim pois pode  ter lixo na comunicação 

at3: .ascii "AT+CWMODE_CUR=1" # chamada para  a função onde está o metodo que o usar linguagem de comandos At que vai inicar a via de  comunicação   entre a esp e broker

at4: .ascii "AT+CIPMUX=0" #chamada para  a função onde está o metodo que o usar linguagem de comandos At  que estabiliza a comunicação entr e o esp e  o broker 

at5: .ascii "AT+CWJAP_CUR=" #chamada para  a função onde está o metodo que o usar linguagem de comandos At para passe o ssdi da rede e password da rede  
at5_p1: .ascii "WLessLEDS" # chamada para  a função onde está o metodo que o usar linguagem de comandos At que encapsula  e enviar o nome da  rede  
at5_p2: .ascii "HelloWorldMP31" # chamada para  a função onde está o metodo que o usar linguagem de comandos At que encapsula  e enviara o passaword (senha) da rede 

at6: .ascii "AT+CIPSTART=" #chamada para  a função onde está o metodo que o usar linguagem de comandos At para  enviar o tipo do protocolo mais o endereço  ip e a porta que vai ser usar pela comunicação 
at6_p1: .ascii "TCP"  #chamada para  a função onde está o metodo que o usar linguagem de comandos At que encapsula  e enviar o tipo de protocolo  da  rede  
at6_p2: .ascii "192.168.43.39" #chamada para  a função onde está o metodo que o usar linguagem de comandos At que encapsula  e enviar o  endereço ip usado na  comunicação  da  rede  
at6_p3: .ascii "1883" # chamada para  a função onde está o metodo que o usar linguagem de comandos At que encapsula  e enviar a porta usada na   rede  

at7: .ascii "AT+CIPSEND=15" #chamada para  a função onde está o metodo que o usar linguagem de comandos At  que verificar se a coneção foi estabelicida com sucesso 
at8: .ascii "AT+CIPSEND=17" #chamada para  a função onde está o metodo que o usar linguagem de comandos At  que verificar  se pode se comunicar 
topico: .ascii "SDTopic" #chamada para  a função onde está o metodo que o usar linguagem de comandos At que para os  metadata enviados pelo Broker assim que estabelecer a conexão 

.text

# r2 recebe os resultados da intrução customizada do lcd
# r3 valores temporários 
# r4 As letras das leds a serem alterados no display 
# r5 endereço de memória dos  botões
# r6 endereço de memória das colunas da matriz de leds
# r7 valores temporários
# r8 endereços de instruções temporariamente
# r10 usado como contador para criar delay
# r13 o endereço de memória das linhas da matriz de leds
# r14 contêm o valor 1 
# custom <id da instrução> <result> <dataA> <dataB>
# Nesta label a instrução customizada é chamada com os parâmetros dos registradores r0 e r3
# Nesse caso r0 indica ao lcd que está sendo enviado um comando e r3 equivale ao comando a ser executado
# Codificação dos Botões:
# 1 - volta ao menu  -  001 (1)
# 2 - seleciona      -  010 (2)
# 3 - pra baixo      -  011 (4)
# 4 - pra cima       -  100 (8)
main:
	addi r14, r0, 1 

	movia r5, 0x3030   # endereço de memórios dos botões
	movia r6, 0x3020   # endereço de memória das colunas
	movia r13, 0x2010  # endereço de memória das linhas
	movia r15, 0x2030  # endereço de memória da uart

 #A função init_lcd realizar o a inicialização do lcd contida no kit  da FPGA
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

# A função send_AT, é um método que através da linguagem de comando AT star 
# o processo de comunicação entre o modulo esp e o broker 
send_AT:
    # está função  vai  iniciar 
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

# A função send_AT_RST, é um método que através da linguagem de comando AT para resetar a 
# comunicação limpando assim pois pode ter lixo na comunicação
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

# A função send_AT_CIPMUX:, é um método que através da linguagem de comando AT que habilite  o recurso
# para que  possa  ocorrer várias comunicação  entre  o esp e broker 
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

#A função send_AT_CWJAP, é um método que através da linguagem de comando AT 
# que inicializar o processo de conexão entre a aplicação e o broker  
# realizar o primeiro processo do handshake
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

# A função init_mqtt, é um método que através da que inicializa a execução 
# do protocolo de comunicação entre o esp e o broker,  esta função compartilha
# da execução  handshake para iniciar a comunicação 
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

# A função send_at8, é um método que através da linguagem 
# de comando AT verificar o retorno do processo do handshake,
# para começa a transmissão de dados entre o esp e broker 
send_at8: 
	movia r7, at8
	addi r10, r0, 13
	add r12, r0, r0

	movia r8, init_mqtt
	subi sp, sp, 8
	stw ra, 1(sp)
	call loop_write_uart_end2

# A função send_at7, é um método que através da linguagem de
# comando AT verificar o envio do processo do handshake, para
# começa a transmissão de dados entre o esp e broker 
send_at7:
	movia r7, at7
	addi r10, r0, 13
	add r12, r0, r0

	movia r8, send_mqtt
	subi sp, sp, 8
	stw ra, 1(sp)
	call loop_write_uart_end2

# A função send_mqtt, é um método que 
# verificar o retorno do processo do handshake, 
# através do protocolo mqtt  para começa a 
# transmissão de dados entre o esp e broker 
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

# A função send_mqtt2, é um método que verificar o envio do processo do handshake,
# através do protocolo mqtt  para começa a transmissão de dados entre o esp e broker 
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

# As funções que tem o prefixo a seguir loop_write_uart,
# realizar um laço de repetição onde ele enviar um dados 
# e desloca para pega o próximo dados que vai ser enviado, 
#isso se repete até  não ter mais dados  que seja  enviado 
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

# A função end_command, detectar que não tem mais dados para
# ser enviado e concluir o lação de repetição 
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

# As funções que tem o prefixo a seguir read_from_uart,
# realizar um laço de repetição onde ele detectar se os dados 
# foram enviado de forma correta e para pega o próximo dados que vai foi retornado
read_from_uart:
	ldwio r3, 0(r15)
	andi r7, r3, 0x8000
	bne r7, r0, read_from_uart_private
	mov r3, r0

read_from_uart_private:
	andi r7, r3, 0x00ff
	mov r3, r7
	ret

# A função clear_uart, realiza  a limpeza do  buffer   
# do uart para evitar  o envio de lixo pelo esp para o broker 
clear_uart:
	ldb r3, 0(r15)
	bne r3, r0, clear_uart
	ret

# A função write_uart, realiza  a escrita no buffer   
# do uart para o envio de dados  pelo esp para o broker 
write_uart:
	subi sp, sp, 4
	stw ra, 0(sp)
	br write_uart_private

# A função write_uart_private, realiza  a escrita no buffer   
# do uart para o envio de dados  pelo esp para o broker  de  forma correta 
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
# Codificação das Leds
# LED A  - 001
# LED B  - 010 
# LED C  - 011 
# LED D  - 100 
# LED E  - 101 

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
	beq r3, r7, frase_selection1  # se o valor dos botões for a opção 1 no caso led A 

	addi r7, r0, 4
	beq r3, r7, led2  # se o valor dos botões for igual a 4 desvia para a label led B 
	
	addi r7, r0, 8
	beq r3, r7, led5  # se o valor dos botões for igual a 8 desvia para a label led E
	
	callr r8  # desvia a execução para o endereço armazenado no registrador, neste caso 'addi r10, r0, 0'

delay: # esta label executa um contador para criar um delay na execução
	addi r10, r10, 1
	ble r10, r7, delay

	ret

led2:
	movia r4, Dois
	
	call menu_lcd  # atualiza o display
	
	nextpc r8    # pega o endereço da próxima instrução

	addi r10, r0, 0
	movia r7, 400000

	call delay

	ldbuio r3, 0(r5) 
	
	addi r7, r0, 2
	beq r3, r7, frase_selection2  # se o valor dos botões for a opção 1 no caso led B 
	
	addi r7, r0, 4
	beq r3, r7, led3   # se o valor dos botões for igual a 4 desvia para a label led C
	
	addi r7, r0, 8
	beq r3, r7, led1   # se o valor dos botões for igual a 8 desvia para a label led A
	
	callr r8      # desvia a execução para o endereço armazenado no registrador, neste caso 'addi r10, r0, 0'
	
led3:
	movia r4, Tres
	
	call menu_lcd    # atualiza o display
	
	nextpc r8        # pega o endereço da próxima instrução

	addi r10, r0, 0
	movia r7, 400000

	call delay

	ldbuio r3, 0(r5) 

	addi r7, r0, 2
	beq r3, r7, frase_selection3  # se o valor dos botões for a opção 3 no caso led C 
	
	addi r7, r0, 4
	beq r3, r7, led4   # se o valor dos botões for igual a 4 desvia para a label led D
	
	addi r7, r0, 8
	beq r3, r7, led2   # se o valor dos botões for igual a 8 desvia para a label led B

	callr r8      # desvia a execução para o endereço armazenado no registrador, neste caso 'addi r10, r0, 0'
	
led4:
	movia r4, Quatro
	
	call menu_lcd  # atualiza o display
	 
	nextpc r8        # pega o endereço da próxima instrução
 
	addi r10, r0, 0
	movia r7, 400000

	call delay

	ldbuio r3, 0(r5) 

	addi r7, r0, 2
	beq r3, r7, frase_selection4   # se o valor dos botões for a opção 4 no caso led D 

	addi r7, r0, 4
	beq r3, r7, led5  # se o valor dos botões for igual a 4 desvia para a label led E
	
	addi r7, r0, 8
	beq r3, r7, led3  # se o valor dos botões for igual a 8 desvia para a label led C
	
	callr r8   # desvia a execução para o endereço armazenado no registrador, neste caso 'addi r10, r0, 0'

led5:
	movia r4, Cinco
	
	call menu_lcd  # atualiza o display
	nextpc r8       # pega o endereço da próxima instrução

	addi r10, r0, 0
	movia r7, 400000

	call delay

	ldbuio r3, 0(r5) 

	addi r7, r0, 2
	beq r3, r7, frase_selection5   # se o valor dos botões for a opção 5 no caso led E 
	
	addi r7, r0, 4
	beq r3, r7, led1  # se o valor dos botões for igual a 4 desvia para a label led A
	
	addi r7, r0, 8
	beq r3, r7, led4  # se o valor dos botões for igual a 8 desvia para a label led D

	callr r8   # desvia a execução para o endereço armazenado no registrador, neste caso 'addi r10, r0, 0'

# As funcções  frase_selection1 , frase_selection2 , frase_selection3 , frase_selection4  e  frase_selection5
# são as a funçoes que vão escrever  no  lcd  opção é led A , ou  opção é led B , ou opção é led C,ou  opção é led D,  opção é led E
# conforme  for a escolha do  usuário através dos botões 
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
	
	call send_at7

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

	call send_at7

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

	call send_at7
	
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

	call send_at7
	
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

	call send_at7
	
	nextpc r8
	
	ldbuio r3, 0(r5)
	
	beq r3, r14, led5
	
	callr r8