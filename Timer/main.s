; main.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; 24/08/2020
; Este programa espera o usu�rio apertar a chave USR_SW1.
; Caso o usu�rio pressione a chave, o LED1 piscar� a cada 0,5 segundo.

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
	

; -------------------------------------------------------------------------------
        THUMB                        ; Instru��es do tipo Thumb-2
; -------------------------------------------------------------------------------
		
; Declara��es EQU - Defines
;<NOME>         EQU <VALOR>
; ========================

; -------------------------------------------------------------------------------
; �rea de Dados - Declara��es de vari�veis
		AREA  DATA, ALIGN=2
		; Se alguma vari�vel for chamada em outro arquivo
		;EXPORT  <var> [DATA,SIZE=<tam>]   ; Permite chamar a vari�vel <var> a 
		                                   ; partir de outro arquivo
;<var>	SPACE <tam>                        ; Declara uma vari�vel de nome <var>
                                           ; de <tam> bytes a partir da primeira 
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
		IMPORT  GPIO_Init
        IMPORT  PortN_Output
        IMPORT  PortJ_Input	
		EXPORT Timer0A_Handler
; -------------------------------------------------------------------------------
; Fun��o main()
Start  		
	BL PLL_Init                  ;Chama a subrotina para alterar o clock do microcontrolador para 80MHz
	BL SysTick_Init
	BL GPIO_Init                 ;Chama a subrotina que inicializa os GPIO
	BL Timer0A_init      ;Chama subrotina que inicializa e habilita interrupcao do timer 0_A
	MOV R10, #0                   ; Rigistrador que armazena o estado do LED
MainLoop
;	MOV R0, #500
;	BL SysTick_Wait1ms
;	PUSH {LR}
;	CMP R10, #0
;	IT EQ
;		MOVEQ R10, #2_10
;	IT NE
;		MOVNE R10, #2_00
;	MOV R0, R10
;	BL PortN_Output				 ;Chamar a fun��o para acender o LED1					 ;return

	B MainLoop                   ;Volta para o la�o principal

;--------------------------------------------------------------------------------
; Fun��o Pisca_LED
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: N�o tem
Pisca_LED
	PUSH {LR}
	CMP R10, #0
	IT EQ
		MOVEQ R10, #2_10
	IT NE
		MOVNE R10, #2_00
	MOV R0, R10
	BL PortN_Output				 ;Chamar a fun��o para acender o LED1
	POP {LR}
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
	LDR R1, =55999999                         
	STR R1, [R0]                          ;Habilita contador para o valor 700ms
	
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