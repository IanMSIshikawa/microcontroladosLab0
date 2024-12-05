; main.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; Ver 1 19/03/2018
; Ver 2 26/08/2018
; Este programa deve esperar o usu�rio pressionar uma chave.
; Caso o usu�rio pressione uma chave, um LED deve piscar a cada 1 segundo.

; -------------------------------------------------------------------------------
        THUMB                        ; Instru��es do tipo Thumb-2
; -------------------------------------------------------------------------------
		
; Declara��es EQU - Defines
;<NOME>         EQU <VALOR>
; ========================
; Defini��es de Valores


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
		IMPORT 	LCD_Init            ; Permite chamar GPIO_Init de outro arquivo
        IMPORT 	setup_LCD            ; Configuração do LCD
		IMPORT send_comand_lcd
        IMPORT send_complex_comand_lcd
        IMPORT send_data_lcd


		IMPORT  GPIO_Init
        ;IMPORT  PortN_Output
        IMPORT  PortJ_Input	
		IMPORT PortQ_Output
		IMPORT PortA_Output
		IMPORT PortP_Output
		IMPORT PortM_Output 
		IMPORT PortL_Input
; -------------------------------------------------------------------------------
; Fun��o main()
Start  		
	BL PLL_Init                  ;Chama a subrotina para alterar o clock do microcontrolador para 80MHz
	BL SysTick_Init              ;Chama a subrotina para inicializar o SysTick
	BL LCD_Init
	BL setup_LCD 
	
	MOV R0, #97
	BL send_data_lcd


MainLoop
; ****************************************
	MOV R0, #97
volta
	BL send_data_lcd
	MOV R2, R0
	MOV R0, #1000
	BL SysTick_Wait1ms
	MOV R0, R2
	ADD R0, R0, #1
	BL volta
; ****************************************


	BL imprimeLed
	BL AscendeLed

;	MOV R0,#2_000000100
;	BL SysTick_Wait1ms
;	MOV R0,#2_1111
;	BL PortQ_Output
;	MOV R0,#2_1100000
;	BL PortP_Output
;	MOV R0,#2_00100000
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
	
	MOV R0,R9;#2_00001111
	;MOV R0,#3
	BL PortQ_Output
	MOV R0,R9;#2_11110000
	BL PortA_Output
	MOV R0,#2_11111111
	BL PortP_Output
	POP{LR}

	BX LR
	
Varredura
	PUSH{LR}
	MOVEQ R8,#0
	MOV R3,#2_00010000
	MOV R5,#1
	
Varredura_loop
	EOR R0,R3,#2_11111111; inverter bits ligados

	BL PortM_Output 
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

	CMP R4, R9 ; R9 = tecla apertada ; R10= n estados
	ITEE EQ
		ADDEQ R10,R10,#1
		MOVNE R10,#10
		MOVNE R9,R4
	
	CMP R10,#10
	ITT EQ
		MOVEQ R10,#0
		MOVEQ R8,#1
		;BNE Varredura
	B Saida_deb
		
imprimeLed
	PUSH{LR}
	
repete
		BL Varredura
		mov R0,#1
		;BL Sys-Tick_Wait1ms
		CMP R8,#1
		IT NE
			BNE repete
		MOV R0,R8

		BL PortQ_Output
		MOV R0,R8
		BL PortP_Output
		;MOV R0,#2_00100000
		
	POP{LR}
	BX LR
	

; -------------------------------------------------------------------------------------------------------------------------
; Fim do Arquivo
; -------------------------------------------------------------------------------------------------------------------------	
    ALIGN                        ;Garante que o fim da se��o est� alinhada 
    END                          ;Fim do arquivo
