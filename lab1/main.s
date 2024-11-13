; main.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; Ver 1 19/03/2018
; Ver 2 26/08/2018
; Este programa deve esperar o usuário pressionar uma chave.
; Caso o usuário pressione uma chave, um LED deve piscar a cada 1 segundo.

; -------------------------------------------------------------------------------
        THUMB                        ; Instruções do tipo Thumb-2
; -------------------------------------------------------------------------------
		
; Declarações EQU - Defines
;<NOME>         EQU <VALOR>
; ========================
; Definições de Valores


; -------------------------------------------------------------------------------
; Área de Dados - Declarações de variáveis
		AREA  DATA, ALIGN=2
		; Se alguma variável for chamada em outro arquivo
		;EXPORT  <var> [DATA,SIZE=<tam>]   ; Permite chamar a variável <var> a 
		                                   ; partir de outro arquivo
;<var>	SPACE <tam>                        ; Declara uma variável de nome <var>
                                           ; de <tam> bytes a partir da primeira 
                                           ; posição da RAM		

; -------------------------------------------------------------------------------
; Área de Código - Tudo abaixo da diretiva a seguir será armazenado na memória de 
;                  código
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma função do arquivo for chamada em outro arquivo	
        EXPORT Start                ; Permite chamar a função Start a partir de 
			                        ; outro arquivo. No caso startup.s
									
		; Se chamar alguma função externa	
        ;IMPORT <func>              ; Permite chamar dentro deste arquivo uma 
									; função <func>
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
; Função main()
Start  		
	BL PLL_Init                  ;Chama a subrotina para alterar o clock do microcontrolador para 80MHz
  	BL SysTick_Init              ;Chama a subrotina para inicializar o SysTick
	BL GPIO_Init                 ;Chama a subrotina que inicializa os GPIO
	
	MOV R0, #0
	MOV R1, #0
	MOV R7, #0
	LDR R3, =500
	MOV R8, #0
	MOV R9, #0
	
MainLoop
; ****************************************
	
wait1s
	;Configura display A, B
	MOV R0, R9
	MOV R1, R8

	;Mostra valores de R0 e R1 nos display DS1 e DS2, respectivamente
	BL DSA_DSB_Output
	
	;Contador para esperar 1s
	ADD R7, R7, #1
	CMP R7, R3
	BNE wait1s
	
	;Verifica se DS2 chegou a 9 e reinicia caso sim
	MOV R0, #9
	CMP R9, R0
	MOV R7, #0
	BNE continua
	MOV R9, #0
	;Verifica se DS1 chegou a 9
	MOV R0, #9
	CMP R8, R0
	BNE continua2
	MOV R8, #0
	B wait1s
	
	
	
continua	
	ADD R9, R9, #1
	B wait1s
	
continua2 
	ADD R8, R8, #1

	
	
; ****************************************
	B MainLoop

;--------------------------------------------------------------------------------
; Função Pisca_LED
; Parâmetro de entrada: Não tem
; Parâmetro de saída: Não tem
Pisca_LED
; ****************************************
; Escrever função que acende o LED, espera 1 segundo, apaga o LED e espera 1 s
; Esta função deve chamar a rotina SysTick_Wait1ms com o parâmetro de entrada em R0
; ****************************************

; -------------------------------------------------------------------------------------------------------------------------
; Fim do Arquivo
; -------------------------------------------------------------------------------------------------------------------------	
    ALIGN                        ;Garante que o fim da seção está alinhada 
    END                          ;Fim do arquivo
