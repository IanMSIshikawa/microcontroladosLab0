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
TRAN_PP5 EQU 2_00100000
TRAN_PB4 EQU 2_00010000
TRAN_PB5 EQU 2_00100000

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
		IMPORT  SysTick_Wait1us			
		IMPORT  GPIO_Init
		IMPORT  PortP_Output
		IMPORT  PortQ_Output
		IMPORT  PortA_Output
		IMPORT  PortB_Output
		IMPORT  PortJ_Input
		IMPORT DecimalTo7Seg
		IMPORT DSA_DSB_Output


; -------------------------------------------------------------------------------
; Fun��o main()
Start  		
	BL PLL_Init                  ;Chama a subrotina para alterar o clock do microcontrolador para 80MHz
  	BL SysTick_Init              ;Chama a subrotina para inicializar o SysTick
	BL GPIO_Init                 ;Chama a subrotina que inicializa os GPIO
	
	MOV R0, #0     ; function parameter
	MOV R1, #0     ; function parameter
	MOV R6, #2_11	   ; estado anterior do bot?o	
	MOV R7, #0     ;couter_update_disp
	LDR R3, =333   ; max update dis
	MOV R8, #0     ; decimal dig 1
	MOV R9, #0     ; decimal dig 2
	MOV R11, #1    ; ascending
	MOV R12, #1    ; step
	MOV R4, #0    ; general_counter [0 - 99]
MainLoop
; ****************************************
	
update_counter
	;Configura display A, B
	MOV R0, R9
	MOV R1, R8

	;Mostra valores de R0 e R1 nos display DS1 e DS2, respectivamente
	BL DSA_DSB_Output
	BL Show_Leds
	;Contador para esperar 1s
	ADD R7, R7, #1
	CMP R7, R3
	
	BNE update_counter ; increase the counter or not
	MOV R7, #0
	CMP R11, #1 ;ASCENDING ORDER?
	BEQ Ascending_Order
	BNE Decrease_Order
			
	
		
end_of_increment
	BL Check_Buttons

	
	B update_counter
; ****************************************
	B MainLoop

;--------------------------------------------------------------------------------
; Fun��o Ascending_Order		
; Par�metro de entrada: R11 (COUNTER)
; Par�metro de sa�da: R9, R8
Ascending_Order		
	CMP R4, #99 ; counter == 0
	IT GT
		MOVGT R4, #0 ;reset counter
	IT LE
		ADDLE R4, R12  ;counter+=step
	MOV R0, #10	
	UDIV R8, R4, R0			  ;R8 recebe o divisor de R4 por 10
	MLS R9, R8, R0, R4 		  ;R9 = R4 - (R8*10) para verificar se ? zero depois
	B end_of_increment
;--------------------------------------------------------------------------------
; Fun��o Decrease_Order
; Par�metro de entrada: R11 (COUNTER)
; Par�metro de sa�da: R9, R8
Decrease_Order
	CMP R4, #0 ; counter == 0
	IT LE
		MOVLE R4, #99 ;reset counter
	IT GT	
		SUBGT R4, R12  ;counter-=step
	MOV R0, #10	
	UDIV R8, R4, R0			  ;R8 recebe o divisor de R4 por 10
	MLS R9, R8, R0, R4 		  ;R9 = R4 - (R8*10) para verificar se ? zero depois
	B end_of_increment

; Fun��o Check_Buttons
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: N�o tem
Check_Buttons
<<<<<<< HEAD
	MOV R1, #2_01;Compara com zero
=======
>>>>>>> 5e1eb80ae6c67bf3843fe7d84525794b13a124d4
	PUSH {LR}
	
	BL PortJ_Input ; call the subroutine that reads the state of the keys and places the result in R0
	PUSH{R0}
	AND R0, R0, #2_01 ;Verifica primeiro bit do port J, correspondente ao J0
	MOV R1, #2_01;Compara com zero
	PUSH{R6}
	AND R6, R6, #2_01
	CMP R0, R6;compara estado anteior e atual
	BEQ j0_not_ascending;nao faz nada caso o estado se manteve
	CMP R6, R1;verifica se ? borda de descida, ou seja, se o estado anterior era 1
	BNE j0_not_ascending; nao faz nada caso seja borda de subida
	
	BL Check_Button_Ascending
	
j0_not_ascending
<<<<<<< HEAD
	MOV R1, #2_10
=======
	MOV R1, #2_10;Compara com 1
	
>>>>>>> 5e1eb80ae6c67bf3843fe7d84525794b13a124d4
	POP{R6}
	ORR R6, R6, R0 
	POP{R0}
	PUSH{R6}
	
	AND R6, R6, #2_10
	

	AND R0, R0, #2_10 ;Verifica segundo bit do port J, correspondente ao J1
	
	CMP R0, R6;compara estado anteior e atual
	BEQ j1_not_ascending;nao faz nada caso o estado se manteve
	CMP R6, R1;verifica se ? borda de subida, ou seja, se o estado anterior era zero
	BNE j1_not_ascending; nao faz nada caso seja borda de descda
	
	BL Check_Button_Step

j1_not_ascending
	POP{R6}
	ORR R6, R6, R0
	
	POP {LR}
	BX LR
;--------------------------------------------------------------------------------
; Fun��o Check_Button_Ascending
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: N�o tem
Check_Button_Ascending
	CMP R11, #1
	IT EQ
		MOVEQ R11, #0
	IT NE
		MOVNE R11, #1
	BX LR

; Fun��o Check_Button_Step
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: N�o tem
Check_Button_Step
	CMP R12, #9
	IT NE
		ADDNE R12, R12, #1
	IT EQ
		MOVEQ R12, #1
	BX LR
; Fun��o Show_Leds
; Par�metro de entrada: R4 (GENERAL COUNTER)
; Par�metro de sa�da: N�o tem
Show_Leds
	PUSH {LR}

	LDR R0, = TRAN_PP5 
	BL PortP_Output ;enable LEDS transistor
	
	MOV R0, R4
	BL PortQ_Output ;show R4 on the LEDS
	BL PortA_Output ;show R4 on the LEDS
	
	MOV R0, #1
	BL SysTick_Wait1ms
	MOV R0, #0 
	BL PortP_Output ;enable LEDS transistor
	;disable led transitor????
	;MOV R0, #0 
	;BL PortP_Output ;enable LEDS transistor
	
	POP {LR}
	BX LR
; Fun��o Pisca_LED
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: N�o tem
Pisca_LED
; ****************************************
; Escrever fun��o que acende o LED, espera 1 segundo, apaga o LED e espera 1 s
; Esta fun��o deve chamar a rotina SysTick_Wait1ms com o par�metro de entrada em R0
; ****************************************

; -------------------------------------------------------------------------------------------------------------------------
; Fim do Arquivo
; -------------------------------------------------------------------------------------------------------------------------	
    ALIGN                        ;Garante que o fim da se��o est� alinhada 
    END                          ;Fim do arquivo
