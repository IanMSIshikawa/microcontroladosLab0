// main.c
// Desenvolvido para a placa EK-TM4C1294XL
// Verifica o estado das chaves USR_SW1 e USR_SW2, acende os LEDs 1 e 2 caso estejam pressionadas independentemente
// Caso as duas chaves estejam pressionadas ao mesmo tempo pisca os LEDs alternadamente a cada 500ms.
// Prof. Guilherme Peron

#include <stdint.h>
void SysTick_Wait1ms(uint32_t delay);
void SysTick_Wait1us(uint32_t delay);

#include "lab3.h"
#include "timer.h"
#include "lcd.h"

#define DEB_LIMIT 75

void PLL_Init(void);
void SysTick_Init(void);
void SysTick_Wait1ms(uint32_t delay);
//void SysTick_Wait1us(uint32_t delay);
void GPIO_Init(void);
uint32_t PortJ_Input(void);
void PortP_Output(uint32_t valor);
void PortQ_Output(uint32_t valor);
void PortN_Output(uint32_t leds);
void PortM_Output_Teclado(uint32_t valor);
uint32_t PortJ_Input(void);
void Pisca_leds(void);


void debounce( uint32_t resultado );
void varredura(void);
void Pisca_LED(uint32_t liga);
void toggle_step_f(void);
void 	reset_all(void);

uint32_t mult_base;// ;R6 = base multiplicac�o
uint32_t mult;//;R7 = estado multiplicador
uint32_t new_key_det;// ;R8 = nova tecla detectada

//uint32_t deb_new_key;//; usado em Varredura
uint32_t deb_key;//;R9 = tecla contagem debounce
uint32_t deb_counter;//;R10= n estados debounce


int main(void)
{
	//reset = 0x00;
	//toggle_step = 0x00;
	//toggle_led = 0x00;

	PLL_Init();
	SysTick_Init();
	GPIO_Init();
	reset_all();
	setup_LCD();
	Timer0A_init();
	Set_Contagem_timer(0);
	while (1)
	{
		varredura();

		int reset_new = get_reset();
		if(reset_new==0x01)
		{
			reset_all();
		}

		int step_new = get_toggle_step();
		if(step_new==0x01)
		{
			toggle_step_f();
		}

		send_complex_comand_lcd(0x01);

		send_string_lcd(mult_base,mult);
		
		Pisca_LED(mult_base);

	}
}

/*void Pisca_leds(void)
{
	PortN_Output(0x2);
	SysTick_Wait1ms(250);
	PortN_Output(0x1);
	SysTick_Wait1ms(250);
}*/

void varredura(void)
{
	uint32_t coluna = 0x10;
	uint32_t offset = 0x1;
	uint32_t leitura;
	uint32_t resultado;

	for (coluna = 0x10; coluna < 0x80; coluna=coluna << 1)
	{
		PortM_Output_Teclado( coluna ^ 0xFF);//EOR R0,R3,#2_11111111; inverter bits ligados
		leitura=PortJ_Input();
		leitura=leitura^0x0F;
		resultado=0xFF;
		if(leitura==0x01)
		{
			resultado=0+offset;
		}
		if(leitura==0x02)
		{
			resultado=3+offset;
		}
		if(leitura==0x04)
		{
			resultado=6+offset;
		}
		if(leitura==0x08)
		{
			resultado=9+offset;
		}
		if (resultado!=0xFF)
		{
			break;
		}
		offset++;
	}
	if(resultado!=0xFF)
	{
		debounce(resultado);
	}
	if(new_key_det!=1)
	{
		return;
	}
	
	Set_Contagem_timer(deb_key);

	if(deb_key!=mult_base)
	{
		mult_base=deb_key;
		mult=0;
		return;
	}
	mult=(mult+1)%10;

	return;

}

void debounce( uint32_t resultado )
{
	if (resultado==11){
		resultado=0;
	}

	if (resultado>=10){
		return;
	}

	if(deb_key!=resultado)
	{
		deb_counter=0;
		deb_key=resultado;
		return;
	}

	++deb_counter;
	
	if(deb_counter==DEB_LIMIT)
	{
		deb_counter=0;
		new_key_det=1;
	}

}



void Pisca_LED(uint32_t liga)
{
	//uint32_t liga = mult_base;
	if(get_toggle_led()==0x01)
	{
		liga = 0x00;
	}
	PortQ_Output(liga);
	PortP_Output(0xFF);

}




void reset_all(void)
{
	mult_base=0;// ;R6 = base multiplicac�o
	mult=0;//;R7 = estado multiplicador
	new_key_det=0;// ;R8 = nova tecla detectada
	//deb_new_key=0;//; usado em Varredura
	deb_key=0;//;R9 = tecla contagem debounce
	deb_counter=0;//;R10= n estados debounce
	
	set_reset(0x00);
}

void toggle_step_f(void)
{
	set_toggle_step(0x00);
}


