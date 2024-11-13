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
GPIO_PORTJ     EQU    2_000000100000000
	

; PORT F
GPIO_PORTF_AHB_LOCK_R    	EQU    0x4005D520
GPIO_PORTF_AHB_CR_R      	EQU    0x4005D524
GPIO_PORTF_AHB_AMSEL_R   	EQU    0x4005D528
GPIO_PORTF_AHB_PCTL_R    	EQU    0x4005D52C
GPIO_PORTF_AHB_DIR_R     	EQU    0x4005D400
GPIO_PORTF_AHB_AFSEL_R   	EQU    0x4005D420
GPIO_PORTF_AHB_DEN_R     	EQU    0x4005D51C
GPIO_PORTF_AHB_PUR_R     	EQU    0x4005D510	
GPIO_PORTF_AHB_DATA_R    	EQU    0x4005D3FC
GPIO_PORTF               	EQU    2_000000000100000	
; PORT A
GPIO_PORTA_AHB_DATA_BITS_R EQU 0x40058000
GPIO_PORTA_AHB_DATA_R EQU 0x400583FC
GPIO_PORTA_AHB_DIR_R EQU 0x40058400
GPIO_PORTA_AHB_IS_R EQU 0x40058404
GPIO_PORTA_AHB_IBE_R EQU 0x40058408
GPIO_PORTA_AHB_IEV_R EQU 0x4005840C
GPIO_PORTA_AHB_IM_R EQU 0x40058410
GPIO_PORTA_AHB_RIS_R EQU 0x40058414
GPIO_PORTA_AHB_MIS_R EQU 0x40058418
GPIO_PORTA_AHB_ICR_R EQU 0x4005841C
GPIO_PORTA_AHB_AFSEL_R EQU 0x40058420
GPIO_PORTA_AHB_DR2R_R EQU 0x40058500
GPIO_PORTA_AHB_DR4R_R EQU 0x40058504
GPIO_PORTA_AHB_DR8R_R EQU 0x40058508
GPIO_PORTA_AHB_ODR_R EQU 0x4005850C
GPIO_PORTA_AHB_PUR_R EQU 0x40058510
GPIO_PORTA_AHB_PDR_R EQU 0x40058514
GPIO_PORTA_AHB_SLR_R EQU 0x40058518
GPIO_PORTA_AHB_DEN_R EQU 0x4005851C
GPIO_PORTA_AHB_LOCK_R EQU 0x40058520
GPIO_PORTA_AHB_CR_R EQU 0x40058524
GPIO_PORTA_AHB_AMSEL_R EQU 0x40058528
GPIO_PORTA_AHB_PCTL_R EQU 0x4005852C
GPIO_PORTA_AHB_ADCCTL_R EQU 0x40058530
GPIO_PORTA_AHB_DMACTL_R EQU 0x40058534
GPIO_PORTA_AHB_SI_R EQU 0x40058538
GPIO_PORTA_AHB_DR12R_R EQU 0x4005853C
GPIO_PORTA_AHB_WAKEPEN_R EQU 0x40058540
GPIO_PORTA_AHB_WAKELVL_R EQU 0x40058544
GPIO_PORTA_AHB_WAKESTAT_R EQU 0x40058548
GPIO_PORTA_AHB_PP_R EQU 0x40058FC0
GPIO_PORTA_AHB_PC_R EQU 0x40058FC4
GPIO_PORTA               	EQU    2_1
; PORT B
GPIO_PORTB_AHB_DATA_BITS_R EQU 0x40059000
GPIO_PORTB_AHB_DATA_R EQU 0x400593FC
GPIO_PORTB_AHB_DIR_R EQU 0x40059400
GPIO_PORTB_AHB_IS_R EQU 0x40059404
GPIO_PORTB_AHB_IBE_R EQU 0x40059408
GPIO_PORTB_AHB_IEV_R EQU 0x4005940C
GPIO_PORTB_AHB_IM_R EQU 0x40059410
GPIO_PORTB_AHB_RIS_R EQU 0x40059414
GPIO_PORTB_AHB_MIS_R EQU 0x40059418
GPIO_PORTB_AHB_ICR_R EQU 0x4005941C
GPIO_PORTB_AHB_AFSEL_R EQU 0x40059420
GPIO_PORTB_AHB_DR2R_R EQU 0x40059500
GPIO_PORTB_AHB_DR4R_R EQU 0x40059504
GPIO_PORTB_AHB_DR8R_R EQU 0x40059508
GPIO_PORTB_AHB_ODR_R EQU 0x4005950C
GPIO_PORTB_AHB_PUR_R EQU 0x40059510
GPIO_PORTB_AHB_PDR_R EQU 0x40059514
GPIO_PORTB_AHB_SLR_R EQU 0x40059518
GPIO_PORTB_AHB_DEN_R EQU 0x4005951C
GPIO_PORTB_AHB_LOCK_R EQU 0x40059520
GPIO_PORTB_AHB_CR_R EQU 0x40059524
GPIO_PORTB_AHB_AMSEL_R EQU 0x40059528
GPIO_PORTB_AHB_PCTL_R EQU 0x4005952C
GPIO_PORTB_AHB_ADCCTL_R EQU 0x40059530
GPIO_PORTB_AHB_DMACTL_R EQU 0x40059534
GPIO_PORTB_AHB_SI_R EQU 0x40059538
GPIO_PORTB_AHB_DR12R_R EQU 0x4005953C
GPIO_PORTB_AHB_WAKEPEN_R EQU 0x40059540
GPIO_PORTB_AHB_WAKELVL_R EQU 0x40059544
GPIO_PORTB_AHB_WAKESTAT_R EQU 0x40059548
GPIO_PORTB_AHB_PP_R EQU 0x40059FC0
GPIO_PORTB_AHB_PC_R EQU 0x40059FC4
GPIO_PORTB EQU 2_10
; PORT P
GPIO_PORTP_AHB_DATA_BITS_R EQU 0x40065000
GPIO_PORTP_AHB_DATA_R EQU 0x400653FC
GPIO_PORTP_AHB_DIR_R EQU 0x40065400
GPIO_PORTP_AHB_IS_R EQU 0x40065404
GPIO_PORTP_AHB_IBE_R EQU 0x40065408
GPIO_PORTP_AHB_IEV_R EQU 0x4006540C
GPIO_PORTP_AHB_IM_R EQU 0x40065410
GPIO_PORTP_AHB_RIS_R EQU 0x40065414
GPIO_PORTP_AHB_MIS_R EQU 0x40065418
GPIO_PORTP_AHB_ICR_R EQU 0x4006541C
GPIO_PORTP_AHB_AFSEL_R EQU 0x40065420
GPIO_PORTP_AHB_DR2R_R EQU 0x40065500
GPIO_PORTP_AHB_DR4R_R EQU 0x40065504
GPIO_PORTP_AHB_DR8R_R EQU 0x40065508
GPIO_PORTP_AHB_ODR_R EQU 0x4006550C
GPIO_PORTP_AHB_PUR_R EQU 0x40065510
GPIO_PORTP_AHB_PDR_R EQU 0x40065514
GPIO_PORTP_AHB_SLR_R EQU 0x40065518
GPIO_PORTP_AHB_DEN_R EQU 0x4006551C
GPIO_PORTP_AHB_LOCK_R EQU 0x40065520
GPIO_PORTP_AHB_CR_R EQU 0x40065524
GPIO_PORTP_AHB_AMSEL_R EQU 0x40065528
GPIO_PORTP_AHB_PCTL_R EQU 0x4006552C
GPIO_PORTP_AHB_ADCCTL_R EQU 0x40065530
GPIO_PORTP_AHB_DMACTL_R EQU 0x40065534
GPIO_PORTP_AHB_SI_R EQU 0x40065538
GPIO_PORTP_AHB_DR12R_R EQU 0x4006553C
GPIO_PORTP_AHB_WAKEPEN_R EQU 0x40065540
GPIO_PORTP_AHB_WAKELVL_R EQU 0x40065544
GPIO_PORTP_AHB_WAKESTAT_R EQU 0x40065548
GPIO_PORTP_AHB_PP_R EQU 0x40065FC0
GPIO_PORTP_AHB_PC_R EQU 0x40065FC4
GPIO_PORTP EQU 8192

; PORT Q
GPIO_PORTQ_AHB_DATA_BITS_R EQU 0x40066000
GPIO_PORTQ_AHB_DATA_R EQU 0x400663FC
GPIO_PORTQ_AHB_DIR_R EQU 0x40066400
GPIO_PORTQ_AHB_IS_R EQU 0x40066404
GPIO_PORTQ_AHB_IBE_R EQU 0x40066408
GPIO_PORTQ_AHB_IEV_R EQU 0x4006640C
GPIO_PORTQ_AHB_IM_R EQU 0x40066410
GPIO_PORTQ_AHB_RIS_R EQU 0x40066414
GPIO_PORTQ_AHB_MIS_R EQU 0x40066418
GPIO_PORTQ_AHB_ICR_R EQU 0x4006641C
GPIO_PORTQ_AHB_AFSEL_R EQU 0x40066420
GPIO_PORTQ_AHB_DR2R_R EQU 0x40066500
GPIO_PORTQ_AHB_DR4R_R EQU 0x40066504
GPIO_PORTQ_AHB_DR8R_R EQU 0x40066508
GPIO_PORTQ_AHB_ODR_R EQU 0x4006650C
GPIO_PORTQ_AHB_PUR_R EQU 0x40066510
GPIO_PORTQ_AHB_PDR_R EQU 0x40066514
GPIO_PORTQ_AHB_SLR_R EQU 0x40066518
GPIO_PORTQ_AHB_DEN_R EQU 0x4006651C
GPIO_PORTQ_AHB_LOCK_R EQU 0x40066520
GPIO_PORTQ_AHB_CR_R EQU 0x40066524
GPIO_PORTQ_AHB_AMSEL_R EQU 0x40066528
GPIO_PORTQ_AHB_PCTL_R EQU 0x4006652C
GPIO_PORTQ_AHB_ADCCTL_R EQU 0x40066530
GPIO_PORTQ_AHB_DMACTL_R EQU 0x40066534
GPIO_PORTQ_AHB_SI_R EQU 0x40066538
GPIO_PORTQ_AHB_DR12R_R EQU 0x4006653C
GPIO_PORTQ_AHB_WAKEPEN_R EQU 0x40066540
GPIO_PORTQ_AHB_WAKELVL_R EQU 0x40066544
GPIO_PORTQ_AHB_WAKESTAT_R EQU 0x40066548
GPIO_PORTQ_AHB_PP_R EQU 0x40066FC0
GPIO_PORTQ_AHB_PC_R EQU 0x40066FC4
GPIO_PORTQ EQU 16384

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
		EXPORT PortA_Output			; Permite chamar PortA_Output de outro arquivo
		EXPORT PortB_Output			; Permite chamar PortB_Output de outro arquivo
		EXPORT PortQ_Output			; Permite chamar PortQ_Output de outro arquivo
		EXPORT PortP_Output			; Permite chamar PortP_Output de outro arquivo	
		EXPORT PortJ_Input          ; Permite chamar PortJ_Input de outro arquivo
		EXPORT DecimalTo7Seg
		EXPORT DSA_DSB_Output
			
		IMPORT SysTick_Wait1ms		;Permite chamar SysTick_Wait1ms no arquivo
									

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
; HABILITA O CLOCK NAS PORTAS A, B, Q, P e J
	LDR     R0, =SYSCTL_RCGCGPIO_R  		
	MOV		R1, #GPIO_PORTA                 
	ORR     R1, #GPIO_PORTB					
	ORR     R1, #GPIO_PORTQ					
	ORR     R1, #GPIO_PORTP					
	ORR     R1, #GPIO_PORTJ
	STR     R1, [R0]	


;AGUARDA SYSCTL_PRGPIO_R FICAR PRONTO
aguarda
	LDR R2, =SYSCTL_PRGPIO_R
	LDR R0, [R2]
	CMP R0, R1
	BNE aguarda
;SETANDO GPIOAMSEL PORTAS A, B, P, Q, J
	LDR R0,=GPIO_PORTA_BASE_R
	ADD R0, R0, #GPIO_AMSEL_R
	LDR R1, =2_00000000
	STR R1, [R0]
	
	LDR R0,=GPIO_PORTB_BASE_R
	ADD R0, R0, #GPIO_AMSEL_R
	LDR R1, =2_00000000
	STR R1, [R0]
	
	LDR R0,=GPIO_PORTP_BASE_R
	ADD R0, R0, #GPIO_AMSEL_R
	LDR R1, =2_00000000
	STR R1, [R0]
	
	LDR R0,=GPIO_PORTQ_BASE_R
	ADD R0, R0, #GPIO_AMSEL_R
	LDR R1, =2_00000000
	STR R1, [R0]
	
	LDR R0,=GPIO_PORTJ_BASE_R
	ADD R0, R0, #GPIO_AMSEL_R
	LDR R1, =2_00000000
	STR R1, [R0]
	
;SETANDO GPIOPCTL DAS PORTAS A, B, P, Q, J

	LDR R0,=GPIO_PORTA_BASE_R
	ADD R0, R0, #GPIO_PCTL_R
	MOV R1, #0
	STR R1, [R0]
	
	LDR R0,=GPIO_PORTB_BASE_R
	ADD R0, R0, #GPIO_PCTL_R
	MOV R1, #0
	STR R1, [R0]
	
	LDR R0,=GPIO_PORTP_BASE_R
	ADD R0, R0, #GPIO_PCTL_R
	MOV R1, #0
	STR R1, [R0]
	
	LDR R0,=GPIO_PORTQ_BASE_R
	ADD R0, R0, #GPIO_PCTL_R
	MOV R1, #0
	STR R1, [R0]
	
	LDR R0,=GPIO_PORTJ_BASE_R
	ADD R0, R0, #GPIO_PCTL_R
	MOV R1, #0
	STR R1, [R0]
	
;SETANDO GPIODIR PARA AS PORTAS A, B, P, Q, J

	LDR R0,=GPIO_PORTA_BASE_R
	ADD R0, R0, #GPIO_DIR_R
	MOV R1, #2_11110000
	STR R1, [R0]
	
	LDR R0,=GPIO_PORTB_BASE_R
	ADD R0, R0, #GPIO_DIR_R
	MOV R1, #2_00110000
	STR R1, [R0]
	
	LDR R0,=GPIO_PORTP_BASE_R
	ADD R0, R0, #GPIO_DIR_R
	MOV R1, #2_00100000
	STR R1, [R0]
	
	LDR R0,=GPIO_PORTQ_BASE_R
	ADD R0, R0, #GPIO_DIR_R
	MOV R1, #2_00001111
	STR R1, [R0]
	
	LDR R0,=GPIO_PORTJ_BASE_R
	ADD R0, R0, #GPIO_DIR_R
	MOV R1, #2_00000000
	STR R1, [R0]
	
;SETANDO GPIOAFSEL PARA AS PORTAS A, B, P, Q, J

	LDR R0,=GPIO_PORTA_BASE_R
	ADD R0, R0, #GPIO_AFSEL_R
	MOV R1, #2_00000000
	STR R1, [R0]
	
	LDR R0,=GPIO_PORTB_BASE_R
	ADD R0, R0, #GPIO_AFSEL_R
	MOV R1, #2_00000000
	STR R1, [R0]
	
	LDR R0,=GPIO_PORTP_BASE_R
	ADD R0, R0, #GPIO_AFSEL_R
	MOV R1, #2_00000000
	STR R1, [R0]
	
	LDR R0,=GPIO_PORTQ_BASE_R
	ADD R0, R0, #GPIO_AFSEL_R
	MOV R1, #2_00000000
	STR R1, [R0]
	
	LDR R0,=GPIO_PORTJ_BASE_R
	ADD R0, R0, #GPIO_AFSEL_R
	MOV R1, #2_00000000
	STR R1, [R0]
	
;SETANDO GPIO_DEN_R PARA AS PORTAS A, B, P, Q, J

	LDR R0,=GPIO_PORTA_BASE_R
	ADD R0, R0, #GPIO_DEN_R
	MOV R1, #2_11110000
	STR R1, [R0]
	
	LDR R0,=GPIO_PORTB_BASE_R
	ADD R0, R0, #GPIO_DEN_R
	MOV R1, #2_00110000
	STR R1, [R0]
	
	LDR R0,=GPIO_PORTP_BASE_R
	ADD R0, R0, #GPIO_DEN_R
	MOV R1, #2_00100000
	STR R1, [R0]
	
	LDR R0,=GPIO_PORTQ_BASE_R
	ADD R0, R0, #GPIO_DEN_R
	MOV R1, #2_00001111
	STR R1, [R0]
	
	LDR R0,=GPIO_PORTJ_BASE_R
	ADD R0, R0, #GPIO_DEN_R
	MOV R1, #2_00000011
	STR R1, [R0]

;SETANDO GPIO_PUR_R DA PORTA J 

	LDR R0,=GPIO_PORTJ_BASE_R
	ADD R0, R0, #GPIO_PUR_R
	MOV R1, #2_00000011
	STR R1, [R0]
	
	BX LR

; -------------------------------------------------------------------------------
; Função PortA_Output
; Parâmetro de entrada: R0 --> se os BIT5-6 estão ligado ou desligado
; Parâmetro de saída: Não tem
PortA_Output
	LDR	R1, =GPIO_PORTA_AHB_DATA_R		    ;Carrega o valor do offset do data register
	;Read-Modify-Write para escrita
	LDR R2, [R1]
	BIC R2, #2_11110000                     ;Primeiro limpamos os dois bits do lido da porta R2 = R2 & 01110000
	ORR R0, R0, R2                          ;Fazer o OR do lido pela porta com o parâmetro de entrada
	STR R0, [R1]                            ;Escreve na porta F o barramento de dados dos pinos F4 e F0
	BX LR									;Retorno

; -------------------------------------------------------------------------------
; Função PortB_Output
; Parâmetro de entrada: R0 --> se os BIT5-4 estão ligado ou desligado
; Parâmetro de saída: Não tem
PortB_Output
	LDR	R1, =GPIO_PORTB_AHB_DATA_R		    ;Carrega o valor do offset do data register
	;Read-Modify-Write para escrita
	LDR R2, [R1]
	BIC R2, #2_00110000                     ;Primeiro limpamos os dois bits do lido da porta R2 = R2 & 2_00110000
	ORR R0, R0, R2                          ;Fazer o OR do lido pela porta com o parâmetro de entrada
	STR R0, [R1]                            ;Escreve na porta F o barramento de dados dos pinos F4 e F0
	BX LR	

; -------------------------------------------------------------------------------
; Função PortQ_Output
; Parâmetro de entrada: R0 --> se os BIT3-0 estão ligado ou desligado
; Parâmetro de saída: Não tem
PortQ_Output
	LDR	R1, =GPIO_PORTQ_AHB_DATA_R		    ;Carrega o valor do offset do data register
	;Read-Modify-Write para escrita
	LDR R2, [R1]
	BIC R2, #2_00001111                     ;Primeiro limpamos os dois bits do lido da porta R2 = R2 & 2_00001111
	ORR R0, R0, R2                          ;Fazer o OR do lido pela porta com o parâmetro de entrada
	STR R0, [R1]                            ;Escreve na porta F o barramento de dados dos pinos F4 e F0
	BX LR	
	
; -------------------------------------------------------------------------------
; Função PortP_Output
; Parâmetro de entrada: R0 --> se os BIT5 esta ligado ou desligado
; Parâmetro de saída: Não tem
PortP_Output
	LDR	R1, =GPIO_PORTP_AHB_DATA_R		    ;Carrega o valor do offset do data register
	;Read-Modify-Write para escrita
	LDR R2, [R1]
	BIC R2, #2_00100000                     ;Primeiro limpamos os dois bits do lido da porta R2 = R2 & 2_00100000
	ORR R0, R0, R2                          ;Fazer o OR do lido pela porta com o parâmetro de entrada
	STR R0, [R1]                            ;Escreve na porta F o barramento de dados dos pinos F4 e F0
	BX LR

; -------------------------------------------------------------------------------
; Função DSA_DSB_Output
; Parâmetro de entrada: r0 -> valor a ser exibido no Display A
;						r1 -> valor a ser exibido no Display B
; Parâmetro de saída: Não tem
DSA_DSB_Output
	
; Usa display 0
	PUSH{LR}
	BL DecimalTo7Seg
	MOV R0, #2_100000
	BL PortB_Output
; Espera poucos ms
	MOV R0, #1
	BL SysTick_Wait1ms
; Usa display B
	MOV R0, R1
	BL DecimalTo7Seg
	MOV R0, #2_10000
	BL PortB_Output

	

	POP {LR}
	BX LR									;Retorno

; -------------------------------------------------------------------------------
; COnverte os números passados por parâmetro para valores usados no display de 7 segmentos
; Recebe o valor e seta as portas PQ0 - PQ3 e PA4 - PA7 responsáveis pelo display
; Usa os registradores R2 e R10
; Parâmetro de entrada: r0 -> valor a ser convertido para 7 segmentos
; Parâmetro de saída: não tem
DecimalTo7Seg
	
	MOV R10, R0
;Seta display quando o valor passado for 0
	MOV R2, #0
	CMP R10, R2
	BNE cmp1
	MOV R0, #2_1111
	PUSH{LR}
	BL PortQ_Output
	MOV R0, #2_110000
	BL PortA_Output
	BL endDecimalTo7Seg
cmp1
;Seta display quando o valor passado for 1
	MOV R2, #1
	CMP R10, R2
	BNE cmp2
	MOV R0, #2_0110
	PUSH{LR}
	BL PortQ_Output
	MOV R0, #0
	BL PortA_Output
	BL endDecimalTo7Seg
cmp2
	MOV R2, #2
	CMP R10, R2
	BNE cmp3
	MOV R0, #2_1011
	PUSH{LR}
	BL PortQ_Output
	MOV R0, #2_1010000
	BL PortA_Output	
	BL endDecimalTo7Seg
cmp3
	MOV R2, #3
	CMP R10, R2
	BNE cmp4
	MOV R0, #2_1111
	PUSH{LR}
	BL PortQ_Output
	MOV R0, #2_1000000
	BL PortA_Output	
	BL endDecimalTo7Seg
cmp4
	MOV R2, #4
	CMP R10, R2
	BNE cmp5
	MOV R0, #2_0110
	PUSH{LR}
	BL PortQ_Output
	MOV R0, #2_1100000
	BL PortA_Output	
	BL endDecimalTo7Seg
cmp5
	MOV R2, #5
	CMP R10, R2
	BNE cmp6
	MOV R0, #2_1101
	PUSH{LR}
	BL PortQ_Output
	MOV R0, #2_1100000
	BL PortA_Output	
	BL endDecimalTo7Seg
cmp6
	MOV R2, #6
	CMP R10, R2
	BNE cmp7
	MOV R0, #2_1101
	PUSH{LR}
	BL PortQ_Output
	MOV R0, #2_1110000
	BL PortA_Output		
	BL endDecimalTo7Seg
cmp7
	MOV R2, #7
	CMP R10, R2
	BNE cmp8
	MOV R0, #2_0111
	PUSH{LR}
	BL PortQ_Output
	MOV R0, #2_0000000
	BL PortA_Output		
	BL endDecimalTo7Seg
cmp8
	MOV R2, #8
	CMP R10, R2
	BNE cmp9
	MOV R0, #2_1111
	PUSH{LR}
	BL PortQ_Output
	MOV R0, #2_1110000
	BL PortA_Output		
	BL endDecimalTo7Seg
cmp9
	MOV R2, #9
	CMP R10, R2
	MOV R0, #2_1111
	PUSH{LR}
	BL PortQ_Output
	MOV R0, #2_1100000
	BL PortA_Output		
	
endDecimalTo7Seg
	POP{LR}
	BX LR ;Retorno
								

; -------------------------------------------------------------------------------
; Função PortJ_Input
; Parâmetro de entrada: Não tem
; Parâmetro de saída: R0 --> o valor da leitura
PortJ_Input
	LDR	R1, =GPIO_PORTJ_AHB_DATA_R		    ;Carrega o valor do offset do data register
	LDR R0, [R1]                            ;Lê no barramento de dados dos pinos [J1-J0]
	BX LR									;Retorno
	




    ALIGN                           ; garante que o fim da seção está alinhada 
    END                             ; fim do arquivo