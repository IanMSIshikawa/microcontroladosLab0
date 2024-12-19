; main.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; Ver 1 19/03/2018
; Ver 2 26/08/2018
; Este programa deve esperar o usu�rio pressionar uma chave.
; Caso o usu�rio pressione uma chave, um LED deve piscar a cada 1 segundo.

; -------------------------------------------------------------------------------
;                               TIMER REGISTERS
; -------------------------------------------------------------------------------
SYSCTL_RCGCTIMER_R      EQU 0x400FE604
SYSCTL_PRTIMER_R        EQU 0x400FEA04
TIMER0_CFG_R            EQU 0x40030000
TIMER0_TAMR_R           EQU 0x40030004
TIMER0_TBMR_R           EQU 0x40030008
TIMER0_CTL_R            EQU 0x4003000C
TIMER0_SYNC_R           EQU 0x40030010
TIMER0_IMR_R            EQU 0x40030018
TIMER0_RIS_R            EQU 0x4003001C
TIMER0_MIS_R            EQU 0x40030020
TIMER0_ICR_R            EQU 0x40030024
TIMER0_TAILR_R          EQU 0x40030028
TIMER0_TBILR_R          EQU 0x4003002C
TIMER0_TAMATCHR_R       EQU 0x40030030
TIMER0_TBMATCHR_R       EQU 0x40030034
TIMER0_TAPR_R           EQU 0x40030038
TIMER0_TBPR_R           EQU 0x4003003C
TIMER0_TAPMR_R          EQU 0x40030040
TIMER0_TBPMR_R          EQU 0x40030044
TIMER0_TAR_R            EQU 0x40030048
TIMER0_TBR_R            EQU 0x4003004C
TIMER0_TAV_R            EQU 0x40030050
TIMER0_TBV_R            EQU 0x40030054
TIMER0_RTCPD_R          EQU 0x40030058
TIMER0_TAPS_R           EQU 0x4003005C
TIMER0_TBPS_R           EQU 0x40030060
TIMER0_DMAEV_R          EQU 0x4003006C
TIMER0_ADCEV_R          EQU 0x40030070
TIMER0_PP_R             EQU 0x40030FC0
TIMER0_CC_R             EQU 0x40030FC8
	
NVIC_PRI4_R             EQU 0xE000E410
NVIC_EN0_R              EQU 0xE000E100
NVIC_EN1_R              EQU 0xE000E104
NVIC_EN2_R              EQU 0xE000E108
NVIC_EN3_R              EQU 0xE000E10C
NVIC_DIS0_R             EQU 0xE000E180
	
INT_WATCHDOG      EQU      34          ; Watchdog Timers 0 and 1
INT_TIMER0A       EQU      35          ; 16/32-Bit Timer 0A
INT_TIMER0B       EQU      36          ; 16/32-Bit Timer 0B
INT_TIMER1A       EQU      37          ; 16/32-Bit Timer 1A
INT_TIMER1B       EQU      38          ; 16/32-Bit Timer 1B
INT_TIMER2A       EQU      39          ; 16/32-Bit Timer 2A
INT_TIMER2B       EQU      40          ; 16/32-Bit Timer 2B
	
CONTAGEM_100_MS   EQU      7999999
CONTAGEM_200_MS   EQU      15999999
CONTAGEM_300_MS   EQU      23999999
CONTAGEM_400_MS   EQU      31999999
CONTAGEM_500_MS   EQU      39999999
CONTAGEM_600_MS   EQU      47999999
CONTAGEM_700_MS   EQU      55999999
CONTAGEM_800_MS   EQU      63999999
CONTAGEM_900_MS   EQU      71999999

ADDRESS_MEMORY_CONTAGEM EQU 0x20001000
ADDRESS_MEMORY_OFFSET   EQU 0x04

ADDRESS_MEMORY_TMP EQU 0x20001A00

; -------------------------------------------------------------------------------
        THUMB                        ; Instru��es do tipo Thumb-2
; -------------------------------------------------------------------------------
		
; Declara��es EQU - Defines
;<NOME>         EQU <VALOR>
; ========================
; Defini��es de Valores
;=======
; Defini��es de Valores
ACENDE_LED EQU 0x20000A08
TOGGLE_LED EQU 0x20000A04
RESET_SW   EQU 0x20000A00



; -------------------------------------------------------------------------------
; �rea de Dados - Declara��es de vari�veis
		AREA  DATA, ALIGN=2
		; Se alguma vari�vel for chamada em outro arquivo
		;EXPORT  <var> [DATA,SIZE=<tam>]   ; Permite chamar a vari�vel <var> a 
		                                   ; partir de outro arquivo
;<var>	SPACE <tam>                        ; Declara uma vari�vel de nome <var>
                                           ; de <tam> bytes a partir da primeira 
                                           ; posi��o da RAM		
;=======
                                           ; posi��o da RAM	

; -------------------------------------------------------------------------------
; �rea de C�digo - Tudo abaixo da diretiva a seguir ser� armazenado na mem�ria de 
;                  c�digo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma fun��o do arquivo for chamada em outro arquivo	
        EXPORT Start                ; Permite chamar a fun��o Start a partir de 
			                        ; outro arquivo. No caso startup.s
									
		; Se chamar alguma fun��o externa	
        ;IMPORT <func>              ; Permite chamar dentro deste arquivo uma 
									; fun��o <func>
		
		IMPORT  PLL_Init
		IMPORT  SysTick_Init
		IMPORT  SysTick_Wait1ms			
		IMPORT 	LCD_Init            ; Permite chamar GPIO_Init de outro arquivo
        IMPORT 	setup_LCD            ; Configuração do LCD
		IMPORT send_comand_lcd
        IMPORT send_complex_comand_lcd
        IMPORT send_data_lcd
		IMPORT send_string_lcd


		IMPORT  GPIO_Init
        IMPORT  PortJ_Input	
		IMPORT PortQ_Output
		IMPORT PortA_Output
		IMPORT PortP_Output
		IMPORT PortM_Output_Teclado 
		IMPORT PortM_Output_LCD
		IMPORT PortL_Input
		EXPORT Timer0A_Handler
		
		
; -------------------------------------------------------------------------------
; Fun��o main()
Start  		
	BL PLL_Init                  ;Chama a subrotina para alterar o clock do microcontrolador para 80MHz
	BL SysTick_Init              ;Chama a subrotina para inicializar o SysTick
	BL GPIO_Init
	BL LCD_Init
	BL setup_LCD 
	BL Load_Contagem_Memoria     ;Chama a subrotina que grava na memoria os valores da contagem
	BL Timer0A_init      ;Chama subrotina que inicializa e habilita interrupcao do timer 0_A
	

LimpaREGS_Tela_LEDS

	MOV R0,#0
	MOV R4,#0 ; usado em Varredura
	MOV R6,#0 ;R6 = base multiplicac�o
	MOV R7,#0 ;R7 = estado multiplicador
	MOV R8,#0 ;R8 = nova tecla detectada
	MOV R9,#0 ;R9 = tecla contagem debounce
	MOV R10,#0 ;R10= n estados debounce

	LDR R0,=RESET_SW
	MOV R1,#0
	STR R1,[R0]
	MOV R0,#0
	MOV R1,#0


MainLoop

	BL faz_Varredura
	
	LDR R0,=RESET_SW
	LDR R0,[R0]
	CMP R0,#1
	IT EQ
		BEQ LimpaREGS_Tela_LEDS
	
	BL AscendeLed
	MOV R0, #0x01
	BL send_complex_comand_lcd
	BL send_string_lcd
	

	B MainLoop

;--------------------------------------------------------------------------------
; Fun��o Pisca_LED
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: N�o tem
Pisca_LED
; Fun��o Pisca_LED
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: N�o tem
AscendeLed
; ****************************************
; Escrever fun��o que acende o LED, espera 1 segundo, apaga o LED e espera 1 s
; Esta fun��o deve chamar a rotina SysTick_Wait1ms com o par�metro de entrada em R0
; ****************************************
	PUSH{LR}
	
	MOV R0,R6;#2_00001111
	;MOV R0,#3
	BL PortQ_Output
	MOV R0,R6;#2_11110000
	BL PortA_Output
	MOV R0,#2_11111111
	BL PortP_Output
	POP{LR}

	BX LR
	
Varredura
	PUSH{LR}
	MOV R8,#0
	MOV R3,#2_00010000
	MOV R5,#1
	
Varredura_loop
	EOR R0,R3,#2_11111111; inverter bits ligados

	BL PortM_Output_Teclado 
	BL PortL_Input

	MOV R4,#2_11111111
	
	EOR R0,R0,#2_1111; inverter bits ligados

	CMP R0, #2_00000001
	IT EQ
		MOVEQ R4,#0
	
	CMP R0, #2_00000010
	IT EQ
		MOVEQ R4,#3
	
	CMP R0, #2_00000100
	IT EQ
		MOVEQ R4,#6
		
	CMP R0, #2_00001000	
	IT EQ
		MOVEQ R4,#9
		
	CMP R4,#2_11111111
	ITT NE
		ADDNE R4,R4,R5
		BNE Debounce_TRUE
		
	ADD R5,R5,#1
	LSL R3,R3,#1
	CMP R3, #2_10000000
	BNE Varredura_loop
	
	
	
SaidaVarredura
	
;	CMP R4,#2_11111111
;	IT NE
;		BNE Debounce_TRUE

Saida_deb
	
	POP{LR}
	BX LR
	
Debounce_TRUE

	CMP R4, #11
	IT EQ
		MOVEQ R4,#0; zerar R4 >=10

	CMP R4, #10
	IT HS
		BHS Saida_deb; sair >=10

	CMP R4, R9 ; R4 = nova tecla apertada ; R9 = tecla contagem debounce ;R10= n estados debounce
	ITEE EQ
		ADDEQ R10,R10,#1
		MOVNE R10,#0
		MOVNE R9,R4
	
	CMP R10,#75
	ITT EQ
		MOVEQ R10,#0
		MOVEQ R8,#1
		;B   Saida_deb	
	
	
		;BNE Varredura
	B Saida_deb
		
faz_Varredura
	PUSH{LR}
	
repete
		BL Varredura
		mov R0,#1
		;BL Sys-Tick_Wait1ms
		LDR R0,=RESET_SW
		LDR R0,[R0]
		CMP R0,#1
		IT EQ
			BEQ saida

		CMP R8,#1
		;IT NE
			;BNE repete
		IT NE
			BNE saida
		CMP R9,R6
		ITTT NE
			MOVNE R6,R9
			MOVNE R7,#0
			BNE saida
		ADD R7,#1
		CMP R7,#10
		IT HS
			MOVHS R7,#0
		
saida
		
	POP{LR}
	BX LR


;--------------------------------------------------------------------------------
; Fun��o Set_Contagem_timer
; Par�metro de entrada: R0 ( 1- 100 ms, 2 -200ms, ..., 9 - 900ms)
; Par�metro de sa�da: N�o tem
Set_Contagem_timer
	PUSH {R0, R1, R2}
	
	MOV R2, R0                            ;Salva o parametro de entrada em R2
	SUB R2, R2, #1

	LDR R0, =ADDRESS_MEMORY_CONTAGEM
	LDR R1, =ADDRESS_MEMORY_OFFSET
	MUL R2, R2, R1
	ADD R2, R2, R0
	LDR R1, [R2]   
	
	LDR R0, =TIMER0_TAILR_R                         
	STR R1, [R0]                          ;Seta o contador para o valor requerido

	POP {R0, R1, R2}
	BX LR
	
;--------------------------------------------------------------------------------
; Fun��o Set_Contagem_timer
; Par�metro de entrada: R0 ( 1- 100 ms, 2 -200ms, ..., 9 - 900ms)
; Par�metro de sa�da: N�o tem
Load_Contagem_Memoria
	PUSH {R0, R1, LR}
	LDR R0, =ADDRESS_MEMORY_CONTAGEM 
	LDR R1, =CONTAGEM_100_MS                         
	STR R1, [R0]                          ;Carrega o valor de contagem de 100 ms no endereco R0
	
	ADD R0, R0, #ADDRESS_MEMORY_OFFSET
	LDR R1, =CONTAGEM_200_MS                         
	STR R1, [R0]                          ;Carrega o valor de contagem de 200 ms no endereco R0
	
	ADD R0, R0, #ADDRESS_MEMORY_OFFSET
	LDR R1, =CONTAGEM_300_MS                         
	STR R1, [R0]                          ;Carrega o valor de contagem de 300 ms no endereco R0
	
	ADD R0, R0, #ADDRESS_MEMORY_OFFSET
	LDR R1, =CONTAGEM_400_MS                         
	STR R1, [R0]                          ;Carrega o valor de contagem de 400 ms no endereco R0
	
	ADD R0, R0, #ADDRESS_MEMORY_OFFSET
	LDR R1, =CONTAGEM_500_MS                         
	STR R1, [R0]                          ;Carrega o valor de contagem de 500 ms no endereco R0
	
	ADD R0, R0, #ADDRESS_MEMORY_OFFSET
	LDR R1, =CONTAGEM_600_MS                         
	STR R1, [R0]                          ;Carrega o valor de contagem de 600 ms no endereco R0
	
	ADD R0, R0, #ADDRESS_MEMORY_OFFSET
	LDR R1, =CONTAGEM_700_MS                         
	STR R1, [R0]                          ;Carrega o valor de contagem de 700 ms no endereco R0

	ADD R0, R0, #ADDRESS_MEMORY_OFFSET
	LDR R1, =CONTAGEM_800_MS                         
	STR R1, [R0]                          ;Carrega o valor de contagem de 800 ms no endereco R0
	
	ADD R0, R0, #ADDRESS_MEMORY_OFFSET
	LDR R1, =CONTAGEM_900_MS                         
	STR R1, [R0]                          ;Carrega o valor de contagem de 900 ms no endereco R0	
	
	POP {R0, R1, LR}
	BX LR	
;--------------------------------------------------------------------------------
; Fun��o Timer0A_Handler
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: N�o tem
Timer0A_Handler
	LDR R1, =TIMER0_ICR_R
	MOV R0, #1
	STR R0, [R1]
	PUSH {LR}
	BL Pisca_LED
	POP {LR}
	BX LR


; -------------------------------------------------------------------------------------------------------------------------
; Funcao Timer0A_init (inicializacao do timer A0)
; -------------------------------------------------------------------------------------------------------------------------
Timer0A_init
	LDR R0, =SYSCTL_RCGCTIMER_R 
	MOV R1, #2_0000001             
	STR R1, [R0]                          ;Habilitar o TIMER 0 no registrador RCGCTIMER
	
	LDR R0, =SYSCTL_PRTIMER_R
Espera_PRTIMER 	
	LDR R1, [R0]
	MOV R2, #2_0000001
	TST     R1, R2							;Testa o R1 com R2 fazendo R1 & R2
	BEQ     Espera_PRTIMER					;Se o flag Z=1, volta para o la�o. Sen�o continua executando
	
	LDR R0, =TIMER0_CTL_R
	MOV R1, #0X00                          
	STR R1, [R0]                          ;Desabilita TIMERS
	
	LDR R0, =TIMER0_CFG_R
	MOV R1, #0X00                          
	STR R1, [R0]                          ;Configura TIMER para 32 bits

	LDR R0, =TIMER0_TAMR_R 
	MOV R1, #0X2                         
	STR R1, [R0]                          ;Habilita modo periodico no TIMER A
	
	LDR R0, =TIMER0_TAILR_R 
	LDR R1, =7999999                        
	STR R1, [R0]                          ;Habilita contador para o valor 100ms
	
	LDR R0, =TIMER0_TAPR_R
	MOV R1, #0X00                          
	STR R1, [R0]                          ;Limpa o preescale (zerado)
	
	LDR R0, =TIMER0_ICR_R
	LDR R1, [R0]
	ORR R1, R1, #0X01                          
	STR R1, [R0]                          ;Limpa a interrupcao do TIMER A
	
	
	LDR R0, =TIMER0_IMR_R
	LDR R1, [R0]
	ORR R1, R1, #0X01                          
	STR R1, [R0]                          ;Seta a interrup��o do TimerA
	
	LDR R0, =NVIC_PRI4_R
	LDR R1, [R0]
	MOV R2, #4
	LSL R2, R2, #29
	ORR R1, R1, R2
	STR R1, [R0]                          ;Seta a prioridade do TIMER A0
	
	LDR R0, =NVIC_EN0_R
	MOV R1, #1
	LSL R1, R1, #19
	STR R1, [R0]                          ;Habilita a interrupcao do TIMER A0
	
	LDR R0, =TIMER0_CTL_R
	MOV R1, #0X01                          
	STR R1, [R0]                          ;Habilita TIMER A
	
	BX LR
	
	

; -------------------------------------------------------------------------------------------------------------------------
; Fim do Arquivo
; -------------------------------------------------------------------------------------------------------------------------	
    ALIGN                        ;Garante que o fim da se��o est� alinhada 
    END                          ;Fim do arquivo
