; Exemplo.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; 12/03/2018

; -------------------------------------------------------------------------------
        THUMB                        ; Instruções do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declarações EQU - Defines
;<NOME>         EQU <VALOR>
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

; -------------------------------------------------------------------------------
; Função main()
random EQU 0x20000A00
order  EQU 0x20000B00
	
Start  
; Comece o código aqui <======================================================

;INSERÇÃO DOS NÚMEROS ALEATÓRIOS A PARTIR DE 0x20000A00

	LDR R0, =0x20000A00   ; Carrega o endereço base de armazenamento
    MOV R1, #193
    STRB R1, [R0], #1     ; Armazena 193 e avança R0
    MOV R1, #63
    STRB R1, [R0], #1     ; Armazena 63 e avança R0
    MOV R1, #176
    STRB R1, [R0], #1     ; Armazena 176 e avança R0
    MOV R1, #127
    STRB R1, [R0], #1     ; Armazena 127 e avança R0
    MOV R1, #43
    STRB R1, [R0], #1     ; Armazena 43 e avança R0
    MOV R1, #13
    STRB R1, [R0], #1     ; Armazena 13 e avança R0
    MOV R1, #211
    STRB R1, [R0], #1     ; Armazena 211 e avança R0
    MOV R1, #3
    STRB R1, [R0], #1     ; Armazena 3 e avança R0
    MOV R1, #203
    STRB R1, [R0], #1     ; Armazena 203 e avança R0
    MOV R1, #5
    STRB R1, [R0], #1     ; Armazena 5 e avança R0
    MOV R1, #21
    STRB R1, [R0], #1     ; Armazena 21 e avança R0
    MOV R1, #7
    STRB R1, [R0], #1     ; Armazena 7 e avança R0
    MOV R1, #206
    STRB R1, [R0], #1     ; Armazena 206 e avança R0
    MOV R1, #245
    STRB R1, [R0], #1     ; Armazena 245 e avança R0
    MOV R1, #157
    STRB R1, [R0], #1     ; Armazena 157 e avança R0
    MOV R1, #237
    STRB R1, [R0], #1     ; Armazena 237 e avança R0
    MOV R1, #241
    STRB R1, [R0], #1     ; Armazena 241 e avança R0
    MOV R1, #105
    STRB R1, [R0], #1     ; Armazena 105 e avança R0
    MOV R1, #252
    STRB R1, [R0], #1     ; Armazena 252 e avança R0
    MOV R1, #19
    STRB R1, [R0], #1     ; Armazena 19 e avança R0

; PROCURA NÚMEROS PRIMOS

	LDR R0, =0x20000A00	  ; Armazena o endereço do número que está sendo analisado
	LDR R5, =0x20000B00	  ; Armazena endereço dos números primos para guardar
lp1	
	MOV R2, #2		
	LDRB R1, [R0], #1		  ;R1 Recebe o número analisado e itera R0
	CBZ R1, fim				  ;Se R1 for zero, implica que acabaram os números a serem verificados
lp2	
	UDIV R3, R1, R2			  ;R3 recebe o divisor de R1 por R2
	MLS R4, R2, R3, R1 		  ;R4 = R1 - (R2*R3) para verificar se é zero depois
	CMP R4, #0				  ;Verifica se R4 é zero, se for zero analisa o proximo número 
	BEQ lp1		      	  		
	ADD R2, R2, #1			  ;Se não for zero, incrementa o divisor em 1
	CMP R2, R1				  ;Compara divisor e número analisado
	BLT lp2					  ;Se for menor, volta no loop e continua analisando o número
	STRB R1, [R5], #1		  ;Se não, implica que não tem nenhum divisor, salva no endereço dos primos
	B lp1
fim 
	MOV R0, #0				  ;R0 armazena o número de números ordenados
	LDR R5, =0x20000B00		  ;Volta R5 para o endereço onde estão os primos	
	LDRB R1, [R5]    		  ;Pega o prieiro numero da comparação
	LDRB R2, [R5, #1]         ;Pega o segundo número da comparação
	CMP R1, R2
	ITT GT
		STRB R2, [R5], #1     ;Número menor recua de posição
		STRB R1, [R5]		  ;Número maior avança 
		
		
		
	
	
	
	NOP
    ALIGN                           ; garante que o fim da seção está alinhada 
    END                             ; fim do arquivo
