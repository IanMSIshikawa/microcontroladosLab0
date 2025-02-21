; gpio.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; Ver 1 19/03/2018
; Ver 2 26/08/2018

; -------------------------------------------------------------------------------
        THUMB                        ; Instru��es do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declara��es EQU - Defines
;=======

;//*****************************************************************************
;//
;// NVIC registers (NVIC)
;//
;//*****************************************************************************
NVIC_ACTLR_R            EQU 0xE000E008
NVIC_ST_CTRL_R          EQU 0xE000E010
NVIC_ST_RELOAD_R        EQU 0xE000E014
NVIC_ST_CURRENT_R       EQU 0xE000E018
NVIC_EN0_R              EQU 0xE000E100
NVIC_EN1_R              EQU 0xE000E104
NVIC_EN2_R              EQU 0xE000E108
NVIC_EN3_R              EQU 0xE000E10C
NVIC_DIS0_R             EQU 0xE000E180
NVIC_DIS1_R             EQU 0xE000E184
NVIC_DIS2_R             EQU 0xE000E188
NVIC_DIS3_R             EQU 0xE000E18C
NVIC_PEND0_R            EQU 0xE000E200
NVIC_PEND1_R            EQU 0xE000E204
NVIC_PEND2_R            EQU 0xE000E208
NVIC_PEND3_R            EQU 0xE000E20C
NVIC_UNPEND0_R          EQU 0xE000E280
NVIC_UNPEND1_R          EQU 0xE000E284
NVIC_UNPEND2_R          EQU 0xE000E288
NVIC_UNPEND3_R          EQU 0xE000E28C
NVIC_ACTIVE0_R          EQU 0xE000E300
NVIC_ACTIVE1_R          EQU 0xE000E304
NVIC_ACTIVE2_R          EQU 0xE000E308
NVIC_ACTIVE3_R          EQU 0xE000E30C
NVIC_PRI0_R             EQU 0xE000E400
NVIC_PRI1_R             EQU 0xE000E404
NVIC_PRI2_R             EQU 0xE000E408
NVIC_PRI3_R             EQU 0xE000E40C
NVIC_PRI4_R             EQU 0xE000E410
NVIC_PRI5_R             EQU 0xE000E414
NVIC_PRI6_R             EQU 0xE000E418
NVIC_PRI7_R             EQU 0xE000E41C
NVIC_PRI8_R             EQU 0xE000E420
NVIC_PRI9_R             EQU 0xE000E424
NVIC_PRI10_R            EQU 0xE000E428
NVIC_PRI11_R            EQU 0xE000E42C
NVIC_PRI12_R            EQU 0xE000E430
NVIC_PRI13_R            EQU 0xE000E434
NVIC_PRI14_R            EQU 0xE000E438
NVIC_PRI15_R            EQU 0xE000E43C
NVIC_PRI16_R            EQU 0xE000E440
NVIC_PRI17_R            EQU 0xE000E444
NVIC_PRI18_R            EQU 0xE000E448
NVIC_PRI19_R            EQU 0xE000E44C
NVIC_PRI20_R            EQU 0xE000E450
NVIC_PRI21_R            EQU 0xE000E454
NVIC_PRI22_R            EQU 0xE000E458
NVIC_PRI23_R            EQU 0xE000E45C
NVIC_PRI24_R            EQU 0xE000E460
NVIC_PRI25_R            EQU 0xE000E464
NVIC_PRI26_R            EQU 0xE000E468
NVIC_PRI27_R            EQU 0xE000E46C
NVIC_PRI28_R            EQU 0xE000E470
NVIC_CPUID_R            EQU 0xE000ED00
NVIC_INT_CTRL_R         EQU 0xE000ED04
NVIC_VTABLE_R           EQU 0xE000ED08
NVIC_APINT_R            EQU 0xE000ED0C
NVIC_SYS_CTRL_R         EQU 0xE000ED10
NVIC_CFG_CTRL_R         EQU 0xE000ED14
NVIC_SYS_PRI1_R         EQU 0xE000ED18
NVIC_SYS_PRI2_R         EQU 0xE000ED1C
NVIC_SYS_PRI3_R         EQU 0xE000ED20
NVIC_SYS_HND_CTRL_R     EQU 0xE000ED24
NVIC_FAULT_STAT_R       EQU 0xE000ED28
NVIC_HFAULT_STAT_R      EQU 0xE000ED2C
NVIC_DEBUG_STAT_R       EQU 0xE000ED30
NVIC_MM_ADDR_R          EQU 0xE000ED34
NVIC_FAULT_ADDR_R       EQU 0xE000ED38
NVIC_CPAC_R             EQU 0xE000ED88
NVIC_MPU_TYPE_R         EQU 0xE000ED90
NVIC_MPU_CTRL_R         EQU 0xE000ED94
NVIC_MPU_NUMBER_R       EQU 0xE000ED98
NVIC_MPU_BASE_R         EQU 0xE000ED9C
NVIC_MPU_ATTR_R         EQU 0xE000EDA0
NVIC_MPU_BASE1_R        EQU 0xE000EDA4
NVIC_MPU_ATTR1_R        EQU 0xE000EDA8
NVIC_MPU_BASE2_R        EQU 0xE000EDAC
NVIC_MPU_ATTR2_R        EQU 0xE000EDB0
NVIC_MPU_BASE3_R        EQU 0xE000EDB4
NVIC_MPU_ATTR3_R        EQU 0xE000EDB8
NVIC_DBG_CTRL_R         EQU 0xE000EDF0
NVIC_DBG_XFER_R         EQU 0xE000EDF4
NVIC_DBG_DATA_R         EQU 0xE000EDF8
NVIC_DBG_INT_R          EQU 0xE000EDFC
NVIC_SW_TRIG_R          EQU 0xE000EF00
NVIC_FPCC_R             EQU 0xE000EF34
NVIC_FPCA_R             EQU 0xE000EF38
NVIC_FPDSC_R            EQU 0xE000EF3C







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

; ========================
; Defini��es dos Ports

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

; PORT J
GPIO_PORTJ_AHB_DATA_BITS_R EQU 0x40060000
GPIO_PORTJ_AHB_DATA_R    EQU 0x400603FC
GPIO_PORTJ_AHB_DIR_R     EQU 0x40060400
GPIO_PORTJ_AHB_IS_R      EQU 0x40060404
GPIO_PORTJ_AHB_IBE_R     EQU 0x40060408
GPIO_PORTJ_AHB_IEV_R     EQU 0x4006040C
GPIO_PORTJ_AHB_IM_R      EQU 0x40060410
GPIO_PORTJ_AHB_RIS_R     EQU 0x40060414
GPIO_PORTJ_AHB_MIS_R     EQU 0x40060418
GPIO_PORTJ_AHB_ICR_R     EQU 0x4006041C
GPIO_PORTJ_AHB_AFSEL_R   EQU 0x40060420
GPIO_PORTJ_AHB_DR2R_R    EQU 0x40060500


GPIO_PORTJ_AHB_DR4R_R    EQU 0x40060504
GPIO_PORTJ_AHB_DR8R_R    EQU 0x40060508
GPIO_PORTJ_AHB_ODR_R     EQU 0x4006050C
GPIO_PORTJ_AHB_PUR_R     EQU 0x40060510
GPIO_PORTJ_AHB_PDR_R     EQU 0x40060514
GPIO_PORTJ_AHB_SLR_R     EQU 0x40060518
GPIO_PORTJ_AHB_DEN_R     EQU 0x4006051C
GPIO_PORTJ_AHB_LOCK_R    EQU 0x40060520
GPIO_PORTJ_AHB_CR_R      EQU 0x40060524
GPIO_PORTJ_AHB_AMSEL_R   EQU 0x40060528
GPIO_PORTJ_AHB_PCTL_R    EQU 0x4006052C
GPIO_PORTJ_AHB_ADCCTL_R  EQU 0x40060530
GPIO_PORTJ_AHB_DMACTL_R  EQU 0x40060534
GPIO_PORTJ_AHB_SI_R      EQU 0x40060538
GPIO_PORTJ_AHB_DR12R_R   EQU 0x4006053C
GPIO_PORTJ_AHB_WAKEPEN_R EQU 0x40060540
GPIO_PORTJ_AHB_WAKELVL_R EQU 0x40060544
GPIO_PORTJ_AHB_WAKESTAT_R EQU 0x40060548
GPIO_PORTJ_AHB_PP_R      EQU 0x40060FC0
GPIO_PORTJ_AHB_PC_R      EQU 0x40060FC4

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





;// GPIO registers (PORTL)
GPIO_PORTL_DATA_BITS_R  EQU 0x40062000
GPIO_PORTL_DATA_R       EQU 0x400623FC
GPIO_PORTL_DIR_R        EQU 0x40062400
GPIO_PORTL_IS_R         EQU 0x40062404
GPIO_PORTL_IBE_R        EQU 0x40062408
GPIO_PORTL_IEV_R        EQU 0x4006240C
GPIO_PORTL_IM_R         EQU 0x40062410
GPIO_PORTL_RIS_R        EQU 0x40062414
GPIO_PORTL_MIS_R        EQU 0x40062418
GPIO_PORTL_ICR_R        EQU 0x4006241C
GPIO_PORTL_AFSEL_R      EQU 0x40062420
GPIO_PORTL_DR2R_R       EQU 0x40062500
GPIO_PORTL_DR4R_R       EQU 0x40062504
GPIO_PORTL_DR8R_R       EQU 0x40062508
GPIO_PORTL_ODR_R        EQU 0x4006250C
GPIO_PORTL_PUR_R        EQU 0x40062510
GPIO_PORTL_PDR_R        EQU 0x40062514
GPIO_PORTL_SLR_R        EQU 0x40062518
GPIO_PORTL_DEN_R        EQU 0x4006251C
GPIO_PORTL_LOCK_R       EQU 0x40062520
GPIO_PORTL_CR_R         EQU 0x40062524
GPIO_PORTL_AMSEL_R      EQU 0x40062528
GPIO_PORTL_PCTL_R       EQU 0x4006252C
GPIO_PORTL_ADCCTL_R     EQU 0x40062530
GPIO_PORTL_DMACTL_R     EQU 0x40062534
GPIO_PORTL_SI_R         EQU 0x40062538
GPIO_PORTL_DR12R_R      EQU 0x4006253C
GPIO_PORTL_WAKEPEN_R    EQU 0x40062540
GPIO_PORTL_WAKELVL_R    EQU 0x40062544
GPIO_PORTL_WAKESTAT_R   EQU 0x40062548
GPIO_PORTL_PP_R         EQU 0x40062FC0
GPIO_PORTL_PC_R         EQU 0x40062FC4
GPIO_PORTL              EQU 2_000010000000000	
	
	
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

; PORT N
GPIO_PORTN_LOCK_R    	EQU    0x40064520
GPIO_PORTN_CR_R      	EQU    0x40064524
GPIO_PORTN_AMSEL_R   	EQU    0x40064528
GPIO_PORTN_PCTL_R    	EQU    0x4006452C
GPIO_PORTN_DIR_R     	EQU    0x40064400
GPIO_PORTN_AFSEL_R   	EQU    0x40064420
GPIO_PORTN_DEN_R     	EQU    0x4006451C
GPIO_PORTN_PUR_R     	EQU    0x40064510	
GPIO_PORTN_DATA_R    	EQU    0x400643FC
GPIO_PORTN_DATA_BITS_R  EQU    0x40064000

	
;DENIFI??O DOS OFFSETS DE CONFIG
GPIO_LOCK_R    	EQU    0x00000520
GPIO_CR_R      	EQU    0x00000524
GPIO_AMSEL_R   	EQU    0x00000528
GPIO_PCTL_R    	EQU    0x0000052C
GPIO_DIR_R     	EQU    0x00000400
GPIO_AFSEL_R   	EQU    0x00000420
GPIO_DEN_R     	EQU    0x0000051C
GPIO_PUR_R     	EQU    0x00000510
		

; VAR

RESET_SW   EQU 0x20000A00

	


; -------------------------------------------------------------------------------
; �rea de C�digo - Tudo abaixo da diretiva a seguir ser� armazenado na mem�ria de 
;                  c�digo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma fun��o do arquivo for chamada em outro arquivo	
        EXPORT GPIO_Init            ; Permite chamar GPIO_Init de outro arquivo
			;EXPORT PortN_Output			; Permite chamar PortN_Output de outro arquivo
		EXPORT PortJ_Input          ; Permite chamar PortJ_Input de outro arquivo
		EXPORT PortA_Output			; Permite chamar PortA_Output de outro arquivo
		EXPORT PortQ_Output			; Permite chamar PortQ_Output de outro arquivo
		EXPORT PortP_Output			; Permite chamar PortP_Output de outro arquivo	
		EXPORT PortM_Output 
		EXPORT PortL_Input
		EXPORT PortM_Output_LCD
		EXPORT PortM_Output_Teclado	
		EXPORT GPIOPortJ_Handler	

;--------------------------------------------------------------------------------
; Fun��o GPIO_Init
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: N�o tem
GPIO_Init
;=====================
; ****************************************
; Escrever fun��o de inicializa��o dos GPIO
; Inicializar as portas M e L
; ****************************************
	LDR     R0, =SYSCTL_RCGCGPIO_R  		
    MOV		R1, #GPIO_PORTM                 
	ORR     R1, #GPIO_PORTL					
	ORR     R1, #GPIO_PORTQ					
	ORR     R1, #GPIO_PORTP
	ORR     R1, #GPIO_PORTA                 						
	ORR     R1, #GPIO_PORTJ
	ORR     R1, #GPIO_PORTK			
	ORR		R1, #GPIO_PORTN
	STR     R1, [R0]	


;AGUARDA SYSCTL_PRGPIO_R FICAR PRONTO
aguarda
	LDR R2, =SYSCTL_PRGPIO_R
	LDR R0, [R2]
	CMP R0, R1
	BNE aguarda
	
;SETANDO GPIOAMSEL PORTAS L e M
	LDR R0,=GPIO_PORTL_BASE_R
	ADD R0, R0, #GPIO_AMSEL_R
	LDR R1, =2_00000000
	STR R1, [R0]
	
	LDR R0,=GPIO_PORTM_BASE_R
	ADD R0, R0, #GPIO_AMSEL_R
	LDR R1, =2_00000000
	STR R1, [R0]
;LCD

	LDR R0,=GPIO_PORTK_BASE_R
	ADD R0, R0, #GPIO_AMSEL_R
	LDR R1, =2_00000000
	STR R1, [R0]

;LEDS
	LDR R0,=GPIO_PORTA_BASE_R
	ADD R0, R0, #GPIO_AMSEL_R
	LDR R1, =2_00000000
	STR R1, [R0]

	LDR R0,=GPIO_PORTQ_BASE_R
	ADD R0, R0, #GPIO_AMSEL_R
	LDR R1, =2_00000000
	STR R1, [R0]

	LDR R0,=GPIO_PORTP_BASE_R
	ADD R0, R0, #GPIO_AMSEL_R
	LDR R1, =2_00000000
	STR R1, [R0]

;BOTAO
	LDR R0,=GPIO_PORTJ_BASE_R
	ADD R0, R0, #GPIO_AMSEL_R
	LDR R1, =2_00000000
	STR R1, [R0]

;TIMER
	LDR R1, =2_00000000
	LDR     R0, =GPIO_PORTN_AMSEL_R			;Carrega o R0 com o endere�o do AMSEL para a porta N
    STR     R1, [R0]					    ;Guarda no registrador AMSEL da porta N da mem�ria

	
;SETANDO GPIOPCTL DAS PORTAS A, B, P, Q, J

	LDR R0,=GPIO_PORTM_BASE_R
	ADD R0, R0, #GPIO_PCTL_R
	MOV R1, #0
	STR R1, [R0]
	
	LDR R0,=GPIO_PORTL_BASE_R
	ADD R0, R0, #GPIO_PCTL_R
	MOV R1, #0
	STR R1, [R0]
;Teclado

	LDR R0,=GPIO_PORTK_BASE_R
	ADD R0, R0, #GPIO_PCTL_R
	MOV R1, #0
	STR R1, [R0]
	
;LEDS

	LDR R0,=GPIO_PORTQ_BASE_R
	ADD R0, R0, #GPIO_PCTL_R
	MOV R1, #0
	STR R1, [R0]

	LDR R0,=GPIO_PORTP_BASE_R
	ADD R0, R0, #GPIO_PCTL_R
	MOV R1, #0
	STR R1, [R0]


	LDR R0,=GPIO_PORTA_BASE_R
	ADD R0, R0, #GPIO_PCTL_R
	MOV R1, #0
	STR R1, [R0]
;BOTAO	
	LDR R0,=GPIO_PORTJ_BASE_R
	ADD R0, R0, #GPIO_PCTL_R
	MOV R1, #0
	STR R1, [R0]
;TIMER
	LDR R1, =2_00000000
	LDR     R0, =GPIO_PORTN_PCTL_R			;Carrega o R0 com o endere�o do AMSEL para a porta N
    STR     R1, [R0]					    ;Guarda no registrador AMSEL da porta N da mem�ria


;SETANDO GPIODIR PARA AS PORTAS A, B, P, Q, J
	LDR R0,=GPIO_PORTL_BASE_R
	ADD R0, R0, #GPIO_DIR_R
	MOV R1, #2_00000000
	STR R1, [R0]
	
	LDR R0,=GPIO_PORTM_BASE_R
	ADD R0, R0, #GPIO_DIR_R
	;MOV R1, #2_11110000
	MOV R1, #2_11110111
	STR R1, [R0]
;LCD

	LDR R0,=GPIO_PORTK_BASE_R
	ADD R0, R0, #GPIO_DIR_R
	MOV R1, #2_11111111
	STR R1, [R0]

;LEDS

	LDR R0,=GPIO_PORTP_BASE_R
	ADD R0, R0, #GPIO_DIR_R
	MOV R1, #2_00100000
	STR R1, [R0]
	
	LDR R0,=GPIO_PORTQ_BASE_R
	ADD R0, R0, #GPIO_DIR_R
	MOV R1, #2_00001111
	STR R1, [R0]

	LDR R0,=GPIO_PORTA_BASE_R
	ADD R0, R0, #GPIO_DIR_R
	MOV R1, #2_11110000
	STR R1, [R0]

;BOTAO
	LDR R0,=GPIO_PORTN_DIR_R
	ADD R0, R0, #GPIO_DIR_R
	MOV R1, #2_0010
	STR R1, [R0]



;SETANDO GPIOAFSEL PARA AS PORTAS A, B, P, Q, J

	LDR R0,=GPIO_PORTM_BASE_R
	ADD R0, R0, #GPIO_AFSEL_R
	MOV R1, #2_00000000
	STR R1, [R0]
	
	LDR R0,=GPIO_PORTL_BASE_R
	ADD R0, R0, #GPIO_AFSEL_R
	MOV R1, #2_00000000
	STR R1, [R0]
	
;LCD

	LDR R0,=GPIO_PORTK_BASE_R
	ADD R0, R0, #GPIO_AFSEL_R
	MOV R1, #2_00000000
	STR R1, [R0]

;LEDS

	LDR R0,=GPIO_PORTA_BASE_R
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

;BOTAO
	LDR R0,=GPIO_PORTJ_BASE_R
	ADD R0, R0, #GPIO_AFSEL_R
	MOV R1, #2_00000000
	STR R1, [R0]
;TIMER
	MOV R1, #2_00000000
    LDR     R0, =GPIO_PORTJ_AHB_AFSEL_R     ;Carrega o endere�o do AFSEL da porta J
    STR     R1, [R0]                        ;Escreve na porta

	
;SETANDO GPIO_DEN_R PARA AS PORTAS M e L

	LDR R0,=GPIO_PORTM_BASE_R
	ADD R0, R0, #GPIO_DEN_R
	MOV R1, #2_11110111
	STR R1, [R0]
	
	LDR R0,=GPIO_PORTL_BASE_R
	ADD R0, R0, #GPIO_DEN_R
	MOV R1, #2_00001111
	STR R1, [R0]

;LCD

	LDR R0,=GPIO_PORTK_BASE_R
	ADD R0, R0, #GPIO_DEN_R
	MOV R1, #2_11111111
	STR R1, [R0]
	
;LEDS

	
	LDR R0,=GPIO_PORTA_BASE_R
	ADD R0, R0, #GPIO_DEN_R
	MOV R1, #2_11110000
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
	MOV R1, #2_00000001
	STR R1, [R0]
	
;SETANDO GPIO_PUR_R DA PORTA L

	LDR R0,=GPIO_PORTL_BASE_R
	ADD R0, R0, #GPIO_PUR_R
	MOV R1, #2_00001111
	STR R1, [R0]
	
	LDR R0,=GPIO_PORTJ_BASE_R
	ADD R0, R0, #GPIO_PUR_R
	MOV R1, #2_00000001
	STR R1, [R0]

;SETANDO  GPIOIM DA PORTA J

	LDR R0,=GPIO_PORTJ_AHB_IM_R
	MOV R1, #2_00000000
	STR R1, [R0]

;SETANDO GPIOIS DA PORTA J

	LDR R0,=GPIO_PORTJ_AHB_IS_R
	MOV R1, #2_00000000
	STR R1, [R0]

;SETANDO GPIOIBE DA PORTA J

	LDR R0,=GPIO_PORTJ_AHB_IBE_R
	MOV R1, #2_00000000
	STR R1, [R0]

;SETANDO GPIOIEV DA PORTA J 

	LDR R0,=GPIO_PORTJ_AHB_IEV_R
	MOV R1, #2_00000001
	STR R1, [R0]


;SETANDO GPIOICR DA PORTA J 

	LDR R0,=GPIO_PORTJ_AHB_ICR_R	
	MOV R1, #2_00000001
	STR R1, [R0] 

;SETANDO GPIOIM DA PORTA J 

	LDR R0,=GPIO_PORTJ_AHB_IM_R	
	MOV R1, #2_00000001
	STR R1, [R0] 

;SETANDO NVIC EN1 DA PORTA J 

	LDR R0,=NVIC_EN1_R
	LDR R1,[R0]
	LDR R2, =0x00080000
	ORR R1,R1,R2
	STR R1, [R0] 

;SETANDO NVIC PRI DA PORTA J 

	LDR R0,=NVIC_PRI12_R
	LDR R1,[R0]
	MOV R2, #5
	LSL R2, #29
	ORR R1,R1,R2
	STR R1, [R0] 

	BX LR
; -------------------------------------------------------------------------------
; Fun��o GPIOPortJ_Handler
; Par�metro de entrada: R0 --> o valor da saida
; Par�metro de sa�da: N�o tem

; -------------------------------------------------------------------------------

GPIOPortJ_Handler

	;Setar o RESET_SW
	LDR R0,=RESET_SW
	MOV R1,#1
	STR R1,[R0]
	MOV R0,#0
	MOV R1,#0

	;SETANDO GPIOICR DA PORTA J --ACK do interrupt

	LDR R0,=GPIO_PORTJ_AHB_ICR_R	
	MOV R1, #2_00000001
	STR R1, [R0] 


	BX LR
; -------------------------------------------------------------------------------


; -------------------------------------------------------------------------------
; Fun��o PortM_Output
; Par�metro de entrada: R0 --> o valor da saida
; Par�metro de sa�da: N�o tem
PortM_Output
; ****************************************
; 
; ****************************************
	LDR	R1, =GPIO_PORTM_DATA_R		    ;Carrega o valor do offset do data register
	;Read-Modify-Write para escrita
	LDR R2, [R1]
	BIC R2, #2_11110000                     ;Primeiro limpamos os dois bits do lido da porta R2 = R2 & 0000 1111
	ORR R0, R0, R2                          ;Fazer o OR do lido pela porta com o par�metro de entrada
	STR R0, [R1]                            ;Escreve na porta M o barramento de dados do pino M7-M4
	BX LR									;Retorno
	
; -------------------------------------------------------------------------------
; Fun��o PortM_Output
; Par�metro de entrada: R0 --> o valor da saida
; Par�metro de sa�da: N�o tem
PortM_Output_LCD
; ****************************************
; 
; ****************************************
	LDR	R1, =GPIO_PORTM_DATA_R		    ;Carrega o valor do offset do data register
	;Read-Modify-Write para escrita
	LDR R2, [R1]
	BIC R2, #2_00000111                  ;Primeiro limpamos os dois bits do lido da porta R2 = R2 & 0000 1111
	ORR R0, R0, R2                          ;Fazer o OR do lido pela porta com o par�metro de entrada
	STR R0, [R1]                            ;Escreve na porta M o barramento de dados do pino M7-M4
	BX LR									;Retorno
; -------------------------------------------------------------------------------
; Fun��o PortM_Output
; Par�metro de entrada: R0 --> o valor da saida
; Par�metro de sa�da: N�o tem
PortM_Output_Teclado
; ****************************************
; 
; ****************************************
	LDR	R1, =GPIO_PORTM_DATA_R		    ;Carrega o valor do offset do data register
	;Read-Modify-Write para escrita
	LDR R2, [R1]
	BIC R2, #2_11110000                     ;Primeiro limpamos os dois bits do lido da porta 
	ORR R0, R0, R2                          ;Fazer o OR do lido pela porta com o par�metro de entrada
	STR R0, [R1]                            ;Escreve na porta F o barramento de dados dos pinos

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
	LDR	R1, =GPIO_PORTJ_AHB_DATA_R		    ;Carrega o valor do offset do data register
	LDR R0, [R1]                            ;L� no barramento de dados dos pinos [J0]
	BX LR									;Retorno
	
							;Retorno
; -------------------------------------------------------------------------------
; Fun��o PortJ_Input
; Par�metro de entrada: N�o tem
; Par�metro d	 sa�da: R0 --> o valor da leitura
PortL_Input
; ****************************************
; Escrever fun��o que l� a chave e retorna 
; um registrador se est� ativada ou n�o
; ****************************************
	LDR	R1, =GPIO_PORTL_DATA_R		    ;Carrega o valor do offset do data register
	LDR R0, [R1]                            ;L� no barramento de dados dos pinos [J0]
	BX LR									;Retorno
	
							;Retorno							
; -------------------------------------------------------------------------------
; Fun��o PortA_Output
; Par�metro de entrada: R0 --> se os BIT5-6 est�o ligado ou desligado
; Par�metro de sa�da: N�o tem
PortA_Output
	LDR	R1, =GPIO_PORTA_AHB_DATA_R		    ;Carrega o valor do offset do data register
	;Read-Modify-Write para escrita
	LDR R2, [R1]
	BIC R2, #2_11110000                     ;Primeiro limpamos os dois bits do lido da porta R2 = R2 & 01110000
	ORR R0, R0, R2                          ;Fazer o OR do lido pela porta com o par�metro de entrada
	STR R0, [R1]                            ;Escreve na porta F o barramento de dados dos pinos F4 e F0
	BX LR									;Retorno

; -------------------------------------------------------------------------------
; Fun��o PortQ_Output
; Par�metro de entrada: R0 --> se os BIT3-0 est�o ligado ou desligado
; Par�metro de sa�da: N�o tem
PortQ_Output
	LDR	R1, =GPIO_PORTQ_AHB_DATA_R		    ;Carrega o valor do offset do data register
	;Read-Modify-Write para escrita
	LDR R2, [R1]
	BIC R2, #2_00001111                     ;Primeiro limpamos os dois bits do lido da porta R2 = R2 & 2_00001111
	ORR R0, R0, R2                          ;Fazer o OR do lido pela porta com o par�metro de entrada
	STR R0, [R1]                            ;Escreve na porta F o barramento de dados dos pinos F4 e F0
	BX LR	

; -------------------------------------------------------------------------------
; Fun��o PortP_Output
; Par�metro de entrada: R0 --> se os BIT5 esta ligado ou desligado
; Par�metro de sa�da: N�o tem
PortP_Output
	LDR	R1, =GPIO_PORTP_AHB_DATA_R		    ;Carrega o valor do offset do data register
	;Read-Modify-Write para escrita
	LDR R2, [R1]
	BIC R2, #2_00100000                     ;Primeiro limpamos os dois bits do lido da porta R2 = R2 & 2_00100000
	ORR R0, R0, R2                          ;Fazer o OR do lido pela porta com o par�metro de entrada
	STR R0, [R1]                            ;Escreve na porta F o barramento de dados dos pinos F4 e F0
	BX LR
	
PortK_Output
	LDR	R1, =GPIO_PORTK_DATA_R		    ;Carrega o valor do offset do data register
	;Read-Modify-Write para escrita
	LDR R2, [R1]
	BIC R2, #2_11111111                     ;Primeiro limpamos os dois bits do lido da porta 
	ORR R0, R0, R2                          ;Fazer o OR do lido pela porta com o par�metro de entrada
	STR R0, [R1]                            ;Escreve na porta F o barramento de dados dos pinos

	BX LR

    ALIGN                           ; garante que o fim da se??o est? alinhada 
    END                             ; fim do arquivo



    ALIGN                           ; garante que o fim da se��o est� alinhada 
    END                             ; fim do arquivo