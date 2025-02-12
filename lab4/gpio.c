// gpio.c
// Desenvolvido para a placa EK-TM4C1294XL
// Inicializa as portas J e N
// Prof. Guilherme Peron


#include <stdint.h>

#include "tm4c1294ncpdt.h"
#include "lab3.h"

#define GPIO_PORTA  (0x0001) //bit 1
#define GPIO_PORTE  (0x0010) //bit 5
#define GPIO_PORTJ  (0x0100) //bit 8
#define GPIO_PORTK  (0x0200) //bit 9
#define GPIO_PORTL  (0x0400) //bit 10
#define GPIO_PORTM  (0x0800) //bit 11
#define GPIO_PORTN  (0x1000) //bit 12
#define GPIO_PORTP  (0x2000) //bit 13
#define GPIO_PORTQ  (0x4000) //bit 14
#define GPIO_PORTH  (0x0080) //bit 7

// -------------------------------------------------------------------------------
// Fun��o GPIO_Init
// Inicializa os ports J e N
// Par�metro de entrada: N�o tem
// Par�metro de sa�da: N�o tem
void GPIO_Init(void)
{
	const uint32_t or_portas = (GPIO_PORTA |
												GPIO_PORTE |
												GPIO_PORTJ |
												GPIO_PORTK |
												GPIO_PORTL |
												GPIO_PORTM |
												GPIO_PORTN |
												GPIO_PORTP |
												GPIO_PORTQ |
												GPIO_PORTH );
//1a. Ativar o clock para a porta setando o bit correspondente no registrador RCGCGPIO
//SYSCTL_RCGCGPIO_R = (GPIO_PORTJ | GPIO_PORTN);
	SYSCTL_RCGCGPIO_R = or_portas;
	SYSCTL_RCGCUART_R |= 0x01; //ativa uart0
//1b.   ap�s isso verificar no PRGPIO se a porta est� pronta para uso.
//while((SYSCTL_PRGPIO_R & (GPIO_PORTJ | GPIO_PORTN) ) != (GPIO_PORTJ | GPIO_PORTN) ){};
	while((SYSCTL_PRGPIO_R & or_portas) != or_portas ){};
	
	// 2. Limpar o AMSEL para desabilitar a anal�gica
	GPIO_PORTJ_AHB_AMSEL_R = 0x00;
	GPIO_PORTA_AHB_AMSEL_R = 0x00;
	GPIO_PORTE_AHB_AMSEL_R = 0x10;
	GPIO_PORTH_AHB_AMSEL_R = 0x00;
	GPIO_PORTK_AMSEL_R = 0x00;
	GPIO_PORTL_AMSEL_R = 0x00;
	GPIO_PORTM_AMSEL_R = 0x00 ;
	GPIO_PORTN_AMSEL_R = 0x00 ;
	GPIO_PORTP_AMSEL_R = 0x00;
	GPIO_PORTQ_AMSEL_R = 0x00;
		
	// 3. Limpar PCTL para selecionar o GPIO		
	GPIO_PORTJ_AHB_PCTL_R = 0x00;
	GPIO_PORTA_AHB_PCTL_R |= 0x00000011; //ativa função alternativa para poder usar uart
	GPIO_PORTH_AHB_PCTL_R = 0x00;
	GPIO_PORTK_PCTL_R = 0x00;
	GPIO_PORTL_PCTL_R = 0x00;
	GPIO_PORTM_PCTL_R = 0x00;
	GPIO_PORTN_PCTL_R = 0x00;
	GPIO_PORTP_PCTL_R = 0x00;
	GPIO_PORTQ_PCTL_R = 0x00;
	
	// 4. DIR para 1 se for entrada, 0 se for sa�da
//	GPIO_PORTJ_AHB_DIR_R = 0x00;
	//GPIO_PORTN_DIR_R = 0x03; //BIT0 | BIT1

	GPIO_PORTJ_AHB_DIR_R = 0x00;
	GPIO_PORTA_AHB_DIR_R = 0xF0 | 0x03;
	GPIO_PORTE_AHB_DIR_R = 0x10;
	GPIO_PORTH_AHB_DIR_R = 0x00;
	GPIO_PORTK_DIR_R = 0xFF; // LCD
	GPIO_PORTL_DIR_R = 0x00;
	GPIO_PORTM_DIR_R = 0xF7;//2_11110111
	GPIO_PORTN_DIR_R = 0x03;//2_0011
	GPIO_PORTP_DIR_R = 0x20;//2_0010 0000
	GPIO_PORTQ_DIR_R = 0x0F;//2_00001111


	// 5. Limpar os bits AFSEL para 0 para selecionar GPIO sem fun��o alternativa	

	GPIO_PORTJ_AHB_AFSEL_R = 0x00;
	GPIO_PORTA_AHB_AFSEL_R = 0x00;//
	GPIO_PORTE_AHB_AFSEL_R = 0x10;//
	GPIO_PORTH_AHB_AFSEL_R = 0x00;//
	GPIO_PORTK_AFSEL_R = 0x00; // 
	GPIO_PORTL_AFSEL_R = 0x00;
	GPIO_PORTM_AFSEL_R = 0x00;//
	GPIO_PORTN_AFSEL_R = 0x00;//
	GPIO_PORTP_AFSEL_R = 0x00;//
	GPIO_PORTQ_AFSEL_R = 0x00;//

	// 6. Setar os bits de DEN para habilitar I/O digital	


	GPIO_PORTJ_AHB_DEN_R = 0x03;
	GPIO_PORTA_AHB_DEN_R = 0xF0;//2_11110000
	GPIO_PORTE_AHB_DEN_R &= ~0x10;
	GPIO_PORTH_AHB_DEN_R = 0x0F;//2_11110000
	GPIO_PORTK_DEN_R = 0xFF; // LCD
	GPIO_PORTL_DEN_R = 0x0F;
	GPIO_PORTM_DEN_R = 0xF7;//2_11110111
	GPIO_PORTN_DEN_R = 0x03;//2_0011
	GPIO_PORTP_DEN_R = 0x20;//2_0010 0000
	GPIO_PORTQ_DEN_R = 0x0F;//2_00001111
	
	// 7. Habilitar resistor de pull-up interno, setar PUR para 1
	GPIO_PORTJ_AHB_PUR_R = 0x03;   //Bit0 e bit1	
		GPIO_PORTL_DEN_R = 0x0F;
	// 8. SETANDO GPIOIM DA PORTA J
	GPIO_PORTJ_AHB_IM_R = 0x00;
	// 9. SETANDO GPIOIS DA PORTA J
	GPIO_PORTJ_AHB_IS_R = 0x00;
	//10. SETANDO GPIOIBE DA PORTA J
	GPIO_PORTJ_AHB_IBE_R = 0x00;
	//11. SETANDO GPIOIEV DA PORTA J 
	GPIO_PORTJ_AHB_IEV_R = 0x03;
	//12. SETANDO GPIOICR DA PORTA J
	GPIO_PORTJ_AHB_ICR_R = 0x03;
	//13. SETANDO GPIOIM DA PORTA J
	GPIO_PORTJ_AHB_IM_R = 0x03; 
	//14. SETANDO NVIC EN1 DA PORTA J 
	NVIC_EN1_R = (NVIC_EN1_R | 0x00080000);
	//15. SETANDO NVIC PRI DA PORTA J 
	NVIC_PRI12_R = ( NVIC_PRI12_R | ( 0x05 << 29 ));
	 
}	

// -------------------------------------------------------------------------------
// Fun��o GPIOPortJ_Handler
// L� os valores de handler do port J
// Par�metro de entrada: vazio
// Par�metro de sa�da: vazio
void GPIOPortJ_Handler(void)
{	
	const uint32_t leitura = ~(GPIO_PORTJ_AHB_DATA_R & 0x03);
	if ((leitura & 0x01) == 0x01 )	//testando bit 0
	{
		//resetar;
		set_reset(0x01);

	}
	if ((leitura & 0x02) == 0x02 )	//testando bit 1
	{
		//altera meio passo -- passo completo
		set_toggle_step(0x01);
	}

	//;SETANDO GPIOICR DA PORTA J --ACK do interrupt
	GPIO_PORTJ_AHB_ICR_R = 0x03;
}

// -------------------------------------------------------------------------------
// Fun��o PortJ_Input
// L� os valores de entrada do port J
// Par�metro de entrada: N�o tem
// Par�metro de sa�da: o valor da leitura do port
uint32_t PortJ_Input(void)
{
	return GPIO_PORTJ_AHB_DATA_R;
}

// -------------------------------------------------------------------------------
// Fun��o PortL_Input
// L� os valores de entrada do port L
// Par�metro de entrada: N�o tem
// Par�metro de sa�da: o valor da leitura do port
uint32_t PortL_Input(void)
{
	return GPIO_PORTL_DATA_R;
}

// -------------------------------------------------------------------------------
// Fun��o PortN_Output
// Escreve os valores no port N
// Par�metro de entrada: Valor a ser escrito
// Par�metro de sa�da: n�o tem
void PortN_Output(uint32_t valor)
{
    uint32_t temp;
    //vamos zerar somente os bits menos significativos
    //para uma escrita amig�vel nos bits 0 e 1
    temp = GPIO_PORTN_DATA_R & (~ 0x03);
    //agora vamos fazer o OR com o valor recebido na fun��o
    temp = temp | valor;
    GPIO_PORTN_DATA_R = temp; 
}

// -------------------------------------------------------------------------------
// Fun��o PortM_Output_Teclado
// Escreve os valores no port M
// Par�metro de entrada: Valor a ser escrito
// Par�metro de sa�da: n�o tem
void PortM_Output_Teclado(uint32_t valor)
{
    uint32_t temp;
    //vamos zerar somente os bits menos significativos
    //para uma escrita amig�vel nos bits 0 e 1
    temp = GPIO_PORTM_DATA_R & (~ 0xF0);
    //agora vamos fazer o OR com o valor recebido na fun��o
    temp = temp | valor;
    GPIO_PORTM_DATA_R = temp; 
}

// -------------------------------------------------------------------------------
// Fun��o PortM_Output_LCD
// Escreve os valores no port M
// Par�metro de entrada: Valor a ser escrito
// Par�metro de sa�da: n�o tem
void PortM_Output_LCD(uint32_t valor)
{
    uint32_t temp;
    //vamos zerar somente os bits menos significativos
    //para uma escrita amig�vel nos bits 0 e 1
    temp = GPIO_PORTM_DATA_R & (~ 0x07);
    //agora vamos fazer o OR com o valor recebido na fun��o
    temp = temp | valor;
    GPIO_PORTM_DATA_R = temp; 
}


// -------------------------------------------------------------------------------
// Fun��o PortA_Output
// Escreve os valores no port N
// Par�metro de entrada: Valor a ser escrito
// Par�metro de sa�da: n�o tem
void PortA_Output(uint32_t valor)
{
    uint32_t temp;
    //vamos zerar somente os bits menos significativos
    //para uma escrita amig�vel nos bits 0 e 1
    temp = GPIO_PORTA_AHB_DATA_R & (~ 0xF0);
    //agora vamos fazer o OR com o valor recebido na fun��o
    temp = temp | valor;
    GPIO_PORTA_AHB_DATA_R = temp; 
}

// -------------------------------------------------------------------------------
// Fun��o PortQ_Output
// Escreve os valores no port Q
// Par�metro de entrada: Valor a ser escrito
// Par�metro de sa�da: n�o tem
void PortQ_Output(uint32_t valor)
{
    uint32_t temp;
    //vamos zerar somente os bits menos significativos
    //para uma escrita amig�vel nos bits 0 e 1
    temp = GPIO_PORTQ_DATA_R & (~ 0x0F);
    //agora vamos fazer o OR com o valor recebido na fun��o
    temp = temp | valor;
    GPIO_PORTQ_DATA_R = temp; 
}

// -------------------------------------------------------------------------------
// Fun��o PortP_Output
// Escreve os valores no port P
// Par�metro de entrada: Valor a ser escrito
// Par�metro de sa�da: n�o tem
void PortP_Output(uint32_t valor)
{
    uint32_t temp;
    //vamos zerar somente os bits menos significativos
    //para uma escrita amig�vel nos bits 0 e 1
    temp = GPIO_PORTP_DATA_R & (~ 0x20);
    //agora vamos fazer o OR com o valor recebido na fun��o
    temp = temp | valor;
    GPIO_PORTP_DATA_R = temp; 
}

// -------------------------------------------------------------------------------
// Fun��o PortK_Output
// Escreve os valores no port K
// Par�metro de entrada: Valora ser escrito
// Par�metro de sa�da: n�o tem
void PortK_Output(uint32_t valor)
{
    uint32_t temp;
    //vamos zerar somente os bits menos significativos
    //para uma escrita amig�vel nos bits 0 e 1
    temp = GPIO_PORTK_DATA_R & (~ 0xFF);
    //agora vamos fazer o OR com o valor recebido na fun��o
    temp = temp | valor;
    GPIO_PORTK_DATA_R = temp; 
}

// -------------------------------------------------------------------------------
// Fun��o PortH_Output
// Escreve os valores no port H
// Par�metro de entrada: Valora ser escrito
// Par�metro de sa�da: n�o tem
void PortH_Output(uint32_t valor)
{
    uint32_t temp;
    //vamos zerar somente os bits menos significativos
    //para uma escrita amig�vel nos bits 0 e 1
    temp = GPIO_PORTK_DATA_R & (~ 0x0F);
    //agora vamos fazer o OR com o valor recebido na fun��o
    temp = temp | valor;
    GPIO_PORTH_AHB_DATA_R = temp; 
}

void initPot(){
	// Passo 6: Habilitar o clock para o módulo ADC0
	SYSCTL_RCGCADC_R |= SYSCTL_RCGCADC_R0;  // Habilita o relógio para o ADC0
	while ((SYSCTL_PRADC_R & SYSCTL_PRADC_R0) == 0) {}  // Espera até o ADC0 estar pronto

	// Passo 7: Escolher a taxa máxima de amostragem
	ADC0_PC_R =  0x0;  // Escolhe a taxa de amostragem máxima para 125k amostras/seg

	// Passo 8: Configurar a prioridade do sequenciador
	ADC0_SSPRI_R = 0x0123; 

	// Passo 9: Desabilitar o sequenciador SS0 para configuração
	ADC0_ACTSS_R &= ~ADC_ACTSS_ASEN0;  // Desabilita o sequenciador SS0

	// Passo 10: Configurar o tipo de gatilho para a conversão (gatilho por software)
	ADC0_EMUX_R &= ~ADC_EMUX_EM0_M;  // Configura o gatilho para software no SS0

	// Passo 11: Configurar a fonte de entrada para o canal AIN9
	ADC0_SSMUX0_R = 9;  // AIN9 (PE4) como entrada para o sequenciador SS0

	// Passo 12: Configurar os bits de controle para a sequência SS0
	ADC0_SSCTL0_R = ADC_SSCTL0_IE0 | ADC_SSCTL0_END0;  // Habilita interrupção e fim de sequência

	// Passo 14: Habilitar o sequenciador SS0
	ADC0_ACTSS_R |= ADC_ACTSS_ASEN0;  // Habilita o sequenciador SS0
}