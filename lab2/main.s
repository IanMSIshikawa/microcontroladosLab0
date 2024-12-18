; main.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; Ver 1 19/03/2018
; Ver 2 26/08/2018
; Este programa deve esperar o usuï¿½rio pressionar uma chave.
; Caso o usuï¿½rio pressione uma chave, um LED deve piscar a cada 1 segundo.

; -------------------------------------------------------------------------------
        THUMB                        ; Instruï¿½ï¿½es do tipo Thumb-2
; -------------------------------------------------------------------------------
		
; Declara½ï¿½es EQU - Defines
;<NOME>         EQU <VALOR>
; ========================
; Definiï¿½ï¿½es de Valores
;=======
; Definições de Valores
ACENDE_LED EQU 0x20000A08
TOGGLE_LED EQU 0x20000A04
RESET_SW   EQU 0x20000A00



; -------------------------------------------------------------------------------
; ï¿½rea de Dados - Declaraï¿½ï¿½es de variï¿½veis
		AREA  DATA, ALIGN=2
		; Se alguma variï¿½vel for chamada em outro arquivo
		;EXPORT  <var> [DATA,SIZE=<tam>]   ; Permite chamar a variï¿½vel <var> a 
		                                   ; partir de outro arquivo
;<var>	SPACE <tam>                        ; Declara uma variï¿½vel de nome <var>
                                           ; de <tam> bytes a partir da primeira 
                                           ; posiï¿½ï¿½o da RAM		
;=======
                                           ; posição da RAM	

; -------------------------------------------------------------------------------
; ï¿½rea de Cï¿½digo - Tudo abaixo da diretiva a seguir serï¿½ armazenado na memï¿½ria de 
;                  cï¿½digo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma funï¿½ï¿½o do arquivo for chamada em outro arquivo	
        EXPORT Start                ; Permite chamar a funï¿½ï¿½o Start a partir de 
			                        ; outro arquivo. No caso startup.s
									
		; Se chamar alguma funï¿½ï¿½o externa	
        ;IMPORT <func>              ; Permite chamar dentro deste arquivo uma 
									; funï¿½ï¿½o <func>
		
		IMPORT  PLL_Init
		IMPORT  SysTick_Init
		IMPORT  SysTick_Wait1ms			
		IMPORT 	LCD_Init            ; Permite chamar GPIO_Init de outro arquivo
        IMPORT 	setup_LCD            ; ConfiguraÃ§Ã£o do LCD
		IMPORT send_comand_lcd
        IMPORT send_complex_comand_lcd
        IMPORT send_data_lcd


		IMPORT  GPIO_Init
        ;IMPORT  PortN_Output
        IMPORT  PortJ_Input	
		IMPORT PortQ_Output
		IMPORT PortA_Output
		IMPORT PortP_Output
		IMPORT PortM_Output_Teclado 
		IMPORT PortM_Output_LCD
		IMPORT PortL_Input
		
		
; -------------------------------------------------------------------------------
; Funï¿½ï¿½o main()
Start  		
	BL PLL_Init                  ;Chama a subrotina para alterar o clock do microcontrolador para 80MHz
	BL SysTick_Init              ;Chama a subrotina para inicializar o SysTick
	BL GPIO_Init
	BL LCD_Init
	BL setup_LCD 
	
	MOV R0, #97
	BL send_data_lcd


LimpaREGS_Tela_LEDS

	MOV R0,#0
	MOV R4,#0 ; usado em Varredura
	MOV R6,#0 ;R6 = base multiplicacão
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

	B MainLoop

;--------------------------------------------------------------------------------
; Funï¿½ï¿½o Pisca_LED
; Parï¿½metro de entrada: Nï¿½o tem
; Parï¿½metro de saï¿½da: Nï¿½o tem
Pisca_LED
; Funï¿½ï¿½o Pisca_LED
; Parï¿½metro de entrada: Nï¿½o tem
; Parï¿½metro de saï¿½da: Nï¿½o tem
AscendeLed
; ****************************************
; Escrever funï¿½ï¿½o que acende o LED, espera 1 segundo, apaga o LED e espera 1 s
; Esta funï¿½ï¿½o deve chamar a rotina SysTick_Wait1ms com o parï¿½metro de entrada em R0
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
	
	CMP R10,#10
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
	

; -------------------------------------------------------------------------------------------------------------------------
; Fim do Arquivo
; -------------------------------------------------------------------------------------------------------------------------	
    ALIGN                        ;Garante que o fim da seï¿½ï¿½o estï¿½ alinhada 
    END                          ;Fim do arquivo
