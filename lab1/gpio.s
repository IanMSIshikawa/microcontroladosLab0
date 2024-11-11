; gpio.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; Ver 1 19/03/2018
; Ver 2 26/08/2018

; -------------------------------------------------------------------------------
        THUMB                        ; Instru��es do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declara��es EQU - Defines
; ========================
; ========================
; Defini��es dos Registradores Gerais
SYSCTL_RCGCGPIO_R	 EQU	0x400FE608
SYSCTL_PRGPIO_R		 EQU    0x400FEA08
; ========================
; Defini��es dos Ports
; PORT J
GPIO_PORTJ_AHB_LOCK_R    	EQU    0x40060520
GPIO_PORTJ_AHB_CR_R      	EQU    0x40060524
GPIO_PORTJ_AHB_AMSEL_R   	EQU    0x40060528
GPIO_PORTJ_AHB_PCTL_R    	EQU    0x4006052C
GPIO_PORTJ_AHB_DIR_R     	EQU    0x40060400
GPIO_PORTJ_AHB_AFSEL_R   	EQU    0x40060420
GPIO_PORTJ_AHB_DEN_R     	EQU    0x4006051C
GPIO_PORTJ_AHB_PUR_R     	EQU    0x40060510	
GPIO_PORTJ_AHB_DATA_R    	EQU    0x400603FC
GPIO_PORTJ               	EQU    2_000000100000000
	
;DEFINI��O DOS TODOS OS PORTS
GPIO_PORTA_BASE_R     EQU    0x40058000
GPIO_PORTB_BASE_R     EQU    0x40059000
GPIO_PORTC_BASE_R     EQU    0x4005A000
GPIO_PORTD_BASE_R     EQU    0x4005B000
GPIO_PORTE_BASE_R     EQU    0x4005C000
GPIO_PORTF_BASE_R     EQU    0x4005D000
GPIO_PORTG_BASE_R     EQU    0x4005E000
GPIO_PORTH_BASE_R     EQU    0x4005F000
GPIO_PORTJ_BASE_R     EQU    0x40060000
GPIO_PORTK_BASE_R     EQU    0x40061000
GPIO_PORTL_BASE_R     EQU    0x40062000
GPIO_PORTM_BASE_R     EQU    0x40063000
GPIO_PORTN_BASE_R     EQU    0x40064000
GPIO_PORTP_BASE_R     EQU    0x40065000
GPIO_PORTQ_BASE_R     EQU    0x40066000
	
;DENIFI��O DOS OFFSETS DE CONFIG
GPIO_LOCK_R    	EQU    0x00000520
GPIO_CR_R      	EQU    0x00000524
GPIO_AMSEL_R   	EQU    0x00000528
GPIO_PCTL_R    	EQU    0x0000052C
GPIO_DIR_R     	EQU    0x00000400
GPIO_AFSEL_R   	EQU    0x00000420
GPIO_DEN_R     	EQU    0x0000051C
GPIO_PUR_R     	EQU    0x00000510	



; -------------------------------------------------------------------------------
; �rea de C�digo - Tudo abaixo da diretiva a seguir ser� armazenado na mem�ria de 
;                  c�digo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma fun��o do arquivo for chamada em outro arquivo	
        EXPORT GPIO_Init            ; Permite chamar GPIO_Init de outro arquivo
		EXPORT PortN_Output			; Permite chamar PortN_Output de outro arquivo
		EXPORT PortJ_Input          ; Permite chamar PortJ_Input de outro arquivo
									

;--------------------------------------------------------------------------------
; Fun��o GPIO_Init
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: N�o tem
GPIO_Init
;=====================
; ****************************************
; Escrever fun��o de inicializa��o dos GPIO
; Inicializar as portas NECESS�RIAS
; ****************************************
;SETANDO PORTAS A, B, P, Q, J para serem usadas
	LDR R0, =2_11000000100011
	LDR R1, =SYSCTL_RCGCGPIO_R
	STR R0, [R1]
;AGUARDA SYSCTL_PRGPIO_R FICAR PRONTO
aguarda
	LDR R1, =SYSCTL_PRGPIO_R
	LDR R0, [R1]
	LDR R1, =2_11000000100011
	CMP R0, R1
	BNE aguarda
;SETANDO GPIOAMSEL PORTAS A, B, P, Q, J
	MOV R0, #GPIO_PORTA_BASE_R
	ADD R0, R0, #GPIO_AMSEL_R
	LDR R1, =2_00000000
	STR R1, [R0]
	
	MOV R0, #GPIO_PORTB_BASE_R
	ADD R0, R0, #GPIO_AMSEL_R
	LDR R1, =2_00000000
	STR R1, [R0]
	
	MOV R0, #GPIO_PORTP_BASE_R
	ADD R0, R0, #GPIO_AMSEL_R
	LDR R1, =2_00000000
	STR R1, [R0]
	
	MOV R0, #GPIO_PORTQ_BASE_R
	ADD R0, R0, #GPIO_AMSEL_R
	LDR R1, =2_00000000
	STR R1, [R0]
	
	MOV R0, #GPIO_PORTJ_BASE_R
	ADD R0, R0, #GPIO_AMSEL_R
	LDR R1, =2_00000000
	STR R1, [R0]
	
;SETANDO GPIOPCTL DAS PORTAS A, B, P, Q, J

	MOV R0, #GPIO_PORTA_BASE_R
	ADD R0, R0, #GPIO_PCTL_R
	MOV R1, #0
	STR R1, [R0]
	
	MOV R0, #GPIO_PORTB_BASE_R
	ADD R0, R0, #GPIO_PCTL_R
	MOV R1, #0
	STR R1, [R0]
	
	MOV R0, #GPIO_PORTP_BASE_R
	ADD R0, R0, #GPIO_PCTL_R
	MOV R1, #0
	STR R1, [R0]
	
	MOV R0, #GPIO_PORTQ_BASE_R
	ADD R0, R0, #GPIO_PCTL_R
	MOV R1, #0
	STR R1, [R0]
	
	MOV R0, #GPIO_PORTJ_BASE_R
	ADD R0, R0, #GPIO_PCTL_R
	MOV R1, #0
	STR R1, [R0]
	
;SETANDO GPIODIR PARA AS PORTAS A, B, P, Q, J

	MOV R0, #GPIO_PORTA_BASE_R
	ADD R0, R0, #GPIO_DIR_R
	MOV R1, #2_11110000
	STR R1, [R0]
	
	MOV R0, #GPIO_PORTB_BASE_R
	ADD R0, R0, #GPIO_DIR_R
	MOV R1, #2_00110000
	STR R1, [R0]
	
	MOV R0, #GPIO_PORTP_BASE_R
	ADD R0, R0, #GPIO_DIR_R
	MOV R1, #2_00100000
	STR R1, [R0]
	
	MOV R0, #GPIO_PORTQ_BASE_R
	ADD R0, R0, #GPIO_DIR_R
	MOV R1, #2_00001111
	STR R1, [R0]
	
	MOV R0, #GPIO_PORTJ_BASE_R
	ADD R0, R0, #GPIO_DIR_R
	MOV R1, #2_00000000
	STR R1, [R0]
	
;SETANDO GPIOAFSEL PARA AS PORTAS A, B, P, Q, J

	MOV R0, #GPIO_PORTA_BASE_R
	ADD R0, R0, #GPIO_AFSEL_R
	MOV R1, #2_00000000
	STR R1, [R0]
	
	MOV R0, #GPIO_PORTB_BASE_R
	ADD R0, R0, #GPIO_AFSEL_R
	MOV R1, #2_00000000
	STR R1, [R0]
	
	MOV R0, #GPIO_PORTP_BASE_R
	ADD R0, R0, #GPIO_AFSEL_R
	MOV R1, #2_00000000
	STR R1, [R0]
	
	MOV R0, #GPIO_PORTQ_BASE_R
	ADD R0, R0, #GPIO_AFSEL_R
	MOV R1, #2_00000000
	STR R1, [R0]
	
	MOV R0, #GPIO_PORTJ_BASE_R
	ADD R0, R0, #GPIO_AFSEL_R
	MOV R1, #2_00000000
	STR R1, [R0]
	
;SETANDO GPIO_DEN_R PARA AS PORTAS A, B, P, Q, J

	MOV R0, #GPIO_PORTA_BASE_R
	ADD R0, R0, #GPIO_DEN_R
	MOV R1, #2_11110000
	STR R1, [R0]
	
	MOV R0, #GPIO_PORTB_BASE_R
	ADD R0, R0, #GPIO_DEN_R
	MOV R1, #2_00110000
	STR R1, [R0]
	
	MOV R0, #GPIO_PORTP_BASE_R
	ADD R0, R0, #GPIO_DEN_R
	MOV R1, #2_00100000
	STR R1, [R0]
	
	MOV R0, #GPIO_PORTQ_BASE_R
	ADD R0, R0, #GPIO_DEN_R
	MOV R1, #2_00001111
	STR R1, [R0]
	
	MOV R0, #GPIO_PORTJ_BASE_R
	ADD R0, R0, #GPIO_DEN_R
	MOV R1, #2_00000011
	STR R1, [R0]

;SETANDO GPIO_PUR_R DA PORTA J 

	MOV R0, #GPIO_PORTJ_BASE_R
	ADD R0, R0, #GPIO_PUR_R
	MOV R1, #2_00000011
	STR R1, [R0]
	
	

	
	
	
	
	BX LR

; -------------------------------------------------------------------------------
; Fun��o PortN_Output
; Par�metro de entrada: 
; Par�metro de sa�da: N�o tem
PortN_Output
; ****************************************
; Escrever fun��o que acende ou apaga o LED
; ****************************************
	
	BX LR
; -------------------------------------------------------------------------------
; Fun��o PortJ_Input
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: R0 --> o valor da leitura
PortJ_Input
; ****************************************
; Escrever fun��o que l� a chave e retorna 
; um registrador se est� ativada ou n�o
; ****************************************
	
	BX LR



    ALIGN                           ; garante que o fim da se��o est� alinhada 
    END                             ; fim do arquivo