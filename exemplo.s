; Exemplo.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; 12/03/2018

; -------------------------------------------------------------------------------
        THUMB                        ; Instru��es do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declara��es EQU - Defines
;<NOME>         EQU <VALOR>
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

; -------------------------------------------------------------------------------
; Fun��o main()
random EQU 0x20000A00
order  EQU 0x20000B00
	
Start  
; Comece o c�digo aqui <======================================================

;INSER��O DOS N�MEROS ALEAT�RIOS A PARTIR DE 0x20000A00

	LDR R0, =0x20000A00   ; Carrega o endere�o base de armazenamento
    MOV R1, #193
    STRB R1, [R0], #1     ; Armazena 193 e avan�a R0
    MOV R1, #63
    STRB R1, [R0], #1     ; Armazena 63 e avan�a R0
    MOV R1, #176
    STRB R1, [R0], #1     ; Armazena 176 e avan�a R0
    MOV R1, #127
    STRB R1, [R0], #1     ; Armazena 127 e avan�a R0
    MOV R1, #43
    STRB R1, [R0], #1     ; Armazena 43 e avan�a R0
    MOV R1, #13
    STRB R1, [R0], #1     ; Armazena 13 e avan�a R0
    MOV R1, #211
    STRB R1, [R0], #1     ; Armazena 211 e avan�a R0
    MOV R1, #3
    STRB R1, [R0], #1     ; Armazena 3 e avan�a R0
    MOV R1, #203
    STRB R1, [R0], #1     ; Armazena 203 e avan�a R0
    MOV R1, #5
    STRB R1, [R0], #1     ; Armazena 5 e avan�a R0
    MOV R1, #21
    STRB R1, [R0], #1     ; Armazena 21 e avan�a R0
    MOV R1, #7
    STRB R1, [R0], #1     ; Armazena 7 e avan�a R0
    MOV R1, #206
    STRB R1, [R0], #1     ; Armazena 206 e avan�a R0
    MOV R1, #245
    STRB R1, [R0], #1     ; Armazena 245 e avan�a R0
    MOV R1, #157
    STRB R1, [R0], #1     ; Armazena 157 e avan�a R0
    MOV R1, #237
    STRB R1, [R0], #1     ; Armazena 237 e avan�a R0
    MOV R1, #241
    STRB R1, [R0], #1     ; Armazena 241 e avan�a R0
    MOV R1, #105
    STRB R1, [R0], #1     ; Armazena 105 e avan�a R0
    MOV R1, #252
    STRB R1, [R0], #1     ; Armazena 252 e avan�a R0
    MOV R1, #19
    STRB R1, [R0], #1     ; Armazena 19 e avan�a R0

; PROCURA N�MEROS PRIMOS

	LDR R0, =0x20000A00	  ; Armazena o endere�o do n�mero que est� sendo analisado
	LDR R5, =0x20000B00	  ; Armazena endere�o dos n�meros primos para guardar
lp1	
	MOV R2, #2		
	LDRB R1, [R0], #1		  ;R1 Recebe o n�mero analisado e itera R0
	CBZ R1, fim				  ;Se R1 for zero, implica que acabaram os n�meros a serem verificados
lp2	
	UDIV R3, R1, R2			  ;R3 recebe o divisor de R1 por R2
	MLS R4, R2, R3, R1 		  ;R4 = R1 - (R2*R3) para verificar se � zero depois
	CMP R4, #0				  ;Verifica se R4 � zero, se for zero analisa o proximo n�mero 
	BEQ lp1		      	  		
	ADD R2, R2, #1			  ;Se n�o for zero, incrementa o divisor em 1
	CMP R2, R1				  ;Compara divisor e n�mero analisado
	BLT lp2					  ;Se for menor, volta no loop e continua analisando o n�mero
	STRB R1, [R5], #1		  ;Se n�o, implica que n�o tem nenhum divisor, salva no endere�o dos primos
	B lp1
fim 
	MOV R0, #0				  ;R0 armazena o n�mero de n�meros ordenados
	LDR R5, =0x20000B00		  ;Volta R5 para o endere�o onde est�o os primos	
	LDRB R1, [R5]    		  ;Pega o prieiro numero da compara��o
	LDRB R2, [R5, #1]         ;Pega o segundo n�mero da compara��o
	CMP R1, R2
	ITT GT
		STRB R2, [R5], #1     ;N�mero menor recua de posi��o
		STRB R1, [R5]		  ;N�mero maior avan�a 
		
		
		
	
	
	
	NOP
    ALIGN                           ; garante que o fim da se��o est� alinhada 
    END                             ; fim do arquivo
