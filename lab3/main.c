// main.c
// Desenvolvido para a placa EK-TM4C1294XL
// Verifica o estado das chaves USR_SW1 e USR_SW2, acende os LEDs 1 e 2 caso estejam pressionadas independentemente
// Caso as duas chaves estejam pressionadas ao mesmo tempo pisca os LEDs alternadamente a cada 500ms.
// Prof. Guilherme Peron

#include <stdint.h>
#include "lcd.h"
#include "lab3.h"

void PLL_Init(void);
void SysTick_Init(void);
void SysTick_Wait1ms(uint32_t delay);
void SysTick_Wait1us(uint32_t delay);
void GPIO_Init(void);
uint32_t PortJ_Input(void);
void PortN_Output(uint32_t leds);
void Pisca_leds(void);
void reset_all(void);
void toggle_step_f(void);

uint32_t mult_base;// ;R6 = base multiplicac�o
uint32_t mult;//;R7 = estado multiplicador
uint32_t new_key_det;// ;R8 = nova tecla detectada

uint32_t deb_new_key;//; usado em Varredura
uint32_t deb_new;//;R9 = tecla contagem debounce
uint32_t deb_counter;//;R10= n estados debounce


int main(void)
{
	PLL_Init();
	SysTick_Init();
	GPIO_Init();
	reset_all();
	while (1)
	{
		int reset_new = get_reset();
		if(reset_new==0x01)
		{
			reset_all();
		}
		int step_new = get_toggle_step();
		if(reset_new==0x01)
		{
			toggle_step_f();
		}
		
	}
}

void Pisca_leds(void)
{
	PortN_Output(0x2);
	SysTick_Wait1ms(250);
	PortN_Output(0x1);
	SysTick_Wait1ms(250);
}

void reset_all(void)
{
	mult_base=0;// ;R6 = base multiplicac�o
	mult=0;//;R7 = estado multiplicador
	new_key_det=0;// ;R8 = nova tecla detectada
	deb_new_key=0;//; usado em Varredura
	deb_new=0;//;R9 = tecla contagem debounce
	deb_counter=0;//;R10= n estados debounce
	set_reset(0x00);
}

void toggle_step_f(void)
{
	set_toggle_step(0x00);
}


