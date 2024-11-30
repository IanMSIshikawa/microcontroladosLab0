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
; PORT N
GPIO_PORTN_AHB_LOCK_R    	EQU    0x40064520
GPIO_PORTN_AHB_CR_R      	EQU    0x40064524
GPIO_PORTN_AHB_AMSEL_R   	EQU    0x40064528
GPIO_PORTN_AHB_PCTL_R    	EQU    0x4006452C
GPIO_PORTN_AHB_DIR_R     	EQU    0x40064400
GPIO_PORTN_AHB_AFSEL_R   	EQU    0x40064420
GPIO_PORTN_AHB_DEN_R     	EQU    0x4006451C
GPIO_PORTN_AHB_PUR_R     	EQU    0x40064510	
GPIO_PORTN_AHB_DATA_R    	EQU    0x400643FC
GPIO_PORTN               	EQU    2_001000000000000	
; PORT M
GPIO_PORTM_DATA_BITS_R EQU  0x40063000
GPIO_PORTM_DATA_R      EQU  0x400633FC
GPIO_PORTM_DIR_R       EQU  0x40063400
GPIO_PORTM_IS_R        EQU  0x40063404
GPIO_PORTM_IBE_R       EQU  0x40063408
GPIO_PORTM_IEV_R       EQU  0x4006340C
GPIO_PORTM_IM_R        EQU  0x40063410
GPIO_PORTM_RIS_R       EQU  0x40063414
GPIO_PORTM_MIS_R       EQU  0x40063418
GPIO_PORTM_ICR_R       EQU  0x4006341C
GPIO_PORTM_AFSEL_R     EQU  0x40063420
GPIO_PORTM_DR2R_R      EQU  0x40063500
GPIO_PORTM_DR4R_R      EQU  0x40063504
GPIO_PORTM_DR8R_R      EQU  0x40063508
GPIO_PORTM_ODR_R       EQU  0x4006350C
GPIO_PORTM_PUR_R       EQU  0x40063510
GPIO_PORTM_PDR_R       EQU  0x40063514
GPIO_PORTM_SLR_R       EQU  0x40063518
GPIO_PORTM_DEN_R       EQU  0x4006351C
GPIO_PORTM_LOCK_R      EQU  0x40063520
GPIO_PORTM_CR_R        EQU  0x40063524
GPIO_PORTM_AMSEL_R     EQU  0x40063528
GPIO_PORTM_PCTL_R      EQU  0x4006352C
GPIO_PORTM_ADCCTL_R    EQU  0x40063530
GPIO_PORTM_DMACTL_R    EQU  0x40063534
GPIO_PORTM_SI_R        EQU  0x40063538
GPIO_PORTM_DR12R_R     EQU  0x4006353C
GPIO_PORTM_WAKEPEN_R   EQU  0x40063540
GPIO_PORTM_WAKELVL_R   EQU  0x40063544
GPIO_PORTM_WAKESTAT_R  EQU  0x40063548
GPIO_PORTM_PP_R        EQU  0x40063FC0
GPIO_PORTM_PC_R        EQU  0x40063FC4
GPIO_PORTM             EQU  2_000100000000000	
; PORT K
GPIO_PORTK_DATA_BITS_R  EQU 0x40061000
GPIO_PORTK_DATA_R       EQU 0x400613FC
GPIO_PORTK_DIR_R        EQU 0x40061400
GPIO_PORTK_IS_R         EQU 0x40061404
GPIO_PORTK_IBE_R        EQU 0x40061408
GPIO_PORTK_IEV_R        EQU 0x4006140C
GPIO_PORTK_IM_R         EQU 0x40061410
GPIO_PORTK_RIS_R        EQU 0x40061414
GPIO_PORTK_MIS_R        EQU 0x40061418
GPIO_PORTK_ICR_R        EQU 0x4006141C
GPIO_PORTK_AFSEL_R      EQU 0x40061420
GPIO_PORTK_DR2R_R       EQU 0x40061500
GPIO_PORTK_DR4R_R       EQU 0x40061504
GPIO_PORTK_DR8R_R       EQU 0x40061508
GPIO_PORTK_ODR_R        EQU 0x4006150C
GPIO_PORTK_PUR_R        EQU 0x40061510
GPIO_PORTK_PDR_R        EQU 0x40061514
GPIO_PORTK_SLR_R        EQU 0x40061518
GPIO_PORTK_DEN_R        EQU 0x4006151C
GPIO_PORTK_LOCK_R       EQU 0x40061520
GPIO_PORTK_CR_R         EQU 0x40061524
GPIO_PORTK_AMSEL_R      EQU 0x40061528
GPIO_PORTK_PCTL_R       EQU 0x4006152C
GPIO_PORTK_ADCCTL_R     EQU 0x40061530
GPIO_PORTK_DMACTL_R     EQU 0x40061534
GPIO_PORTK_SI_R         EQU 0x40061538
GPIO_PORTK_DR12R_R      EQU 0x4006153C
GPIO_PORTK_WAKEPEN_R    EQU 0x40061540
GPIO_PORTK_WAKELVL_R    EQU 0x40061544
GPIO_PORTK_WAKESTAT_R   EQU 0x40061548
GPIO_PORTK_PP_R         EQU 0x40061FC0
GPIO_PORTK_PC_R         EQU 0x40061FC4
GPIO_PORTK              EQU 2_000001000000000	






; -------------------------------------------------------------------------------
; �rea de C�digo - Tudo abaixo da diretiva a seguir ser� armazenado na mem�ria de 
;                  c�digo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma fun��o do arquivo for chamada em outro arquivo	
        EXPORT LCD_Init            ; Permite chamar GPIO_Init de outro arquivo
        EXPORT setup_LCD            ; Configuração do LCD
									

;--------------------------------------------------------------------------------
; Fun��o LCD_Init
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: N�o tem
LCD_Init
;=====================
; ****************************************
; Escrever fun��o de inicializa��o dos GPIO
; HABILITA O CLOCK NAS PORTAS
	LDR     R0, =SYSCTL_RCGCGPIO_R  		
	MOV		R1, #GPIO_PORTM                 
	ORR     R1, #GPIO_PORTK					
	STR     R1, [R0]	


;AGUARDA SYSCTL_PRGPIO_R FICAR PRONTO
aguarda
	LDR R2, =SYSCTL_PRGPIO_R
	LDR R0, [R2]
	CMP R0, R1
	BNE aguarda
;SETANDO GPIOAMSEL PORTAS 
	LDR R0,=GPIO_PORTM_BASE_R
	ADD R0, R0, #GPIO_AMSEL_R
	LDR R1, =2_00000000
	STR R1, [R0]

	LDR R0,=GPIO_PORTK_BASE_R
	ADD R0, R0, #GPIO_AMSEL_R
	LDR R1, =2_00000000
	STR R1, [R0]
;SETANDO GPIOPCTL DAS PORTAS 

	LDR R0,=GPIO_PORTM_BASE_R
	ADD R0, R0, #GPIO_PCTL_R
	MOV R1, #0
	STR R1, [R0]

	LDR R0,=GPIO_PORTK_BASE_R
	ADD R0, R0, #GPIO_PCTL_R
	MOV R1, #0
	STR R1, [R0]
;SETANDO GPIODIR PARA AS PORTAS 

	LDR R0,=GPIO_PORTM_BASE_R
	ADD R0, R0, #GPIO_DIR_R
	MOV R1, #2_111
	STR R1, [R0]

	LDR R0,=GPIO_PORTK_BASE_R
	ADD R0, R0, #GPIO_DIR_R
	MOV R1, #2_11111111
	STR R1, [R0]

;SETANDO GPIOAFSEL PARA AS PORTAS 

	LDR R0,=GPIO_PORTM_BASE_R
	ADD R0, R0, #GPIO_AFSEL_R
	MOV R1, #2_00000000
	STR R1, [R0]

	LDR R0,=GPIO_PORTK_BASE_R
	ADD R0, R0, #GPIO_AFSEL_R
	MOV R1, #2_00000000
	STR R1, [R0]

;SETANDO GPIO_DEN_R PARA AS PORTAS A, B, P, Q, J

	LDR R0,=GPIO_PORTM_BASE_R
	ADD R0, R0, #GPIO_DEN_R
	MOV R1, #2_111
	STR R1, [R0]

	LDR R0,=GPIO_PORTM_BASE_R
	ADD R0, R0, #GPIO_DEN_R
	MOV R1, #2_11111111
	STR R1, [R0]

	BX LR
; ****************************************

; ****************************************

setup_LCD

    ;Inicializar no modo 2 linhas / caracter matriz 5x7 (0x38)
    MOV R0, #0x38
    BL send_comand_lcd

    ;Cursor com autoincremento para direita (0x06)
    MOV R0, #0x06
    BL send_comand_lcd

    ;Configurar o cursor (habilitar o display + cursor não-pisca) (0x0E) 
    MOV R0, #0x0E
    BL send_comand_lcd

    ;Resetar: Limpar o display e levar o cursor para o home (0x01)
    MOV R0, #0x01
    BL send_complex_comand_lcd

    BX LR

; *******************************
;r0 -> comando a ser executado
send_comand_lcd

    ;pm0 -> INTRUÇÃO/DADO (0/1)
    ;pm1 -> write/read (0/1)
    ;pm2 -> enable

    ;carrega comando 
    BL PortK_Output

    ;seta pinos pm0, pm1, pm2 para intrução, write, enable
    MOV R0, #2_100
    BL PortM_Output

    ;espera por 10us
    MOV R0, #10
    BL SysTick_Wait1us

    ;desabilita e espera 40us
    MOV R0, #2_000
    BL PortM_Output
    MOV R0, #40
    BL SysTick_Wait1us

    BX LR

; *******************************
;r0 -> comando a ser executado
send_complex_comand_lcd

    ;pm0 -> INTRUÇÃO/DADO (0/1)
    ;pm1 -> write/read (0/1)
    ;pm2 -> enable

    ;carrega comando 
    BL PortK_Output

    ;seta pinos pm0, pm1, pm2 para intrução, write, enable
    MOV R0, #2_100
    BL PortM_Output

    ;espera por 10us
    MOV R0, #10
    BL SysTick_Wait1us

    ;desabilita e espera 1,64ms
    MOV R0, #2_000
    BL PortM_Output
    MOV R0, #1640
    BL SysTick_Wait1us

    BX LR

; *******************************
;r0 -> comando a ser executado
send_data_lcd

    ;pm0 -> INTRUÇÃO/DADO (0/1)
    ;pm1 -> write/read (0/1)
    ;pm2 -> enable

    ;carrega dado 
    BL PortK_Output

    ;seta pinos pm0, pm1, pm2 para dado, write, enable
    MOV R0, #2_101
    BL PortM_Output

    ;espera por 10us
    MOV R0, 10
    BL SysTick_Wait1us

    ;desabilita e espera 40us
    MOV R0, #2_000
    BL PortM_Output
    MOV R0, 40
    BL SysTick_Wait1us



    BX LR

    ALIGN                           ; garante que o fim da se��o est� alinhada 
    END                             ; fim do arquivo