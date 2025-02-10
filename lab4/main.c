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
#include "motor.h"

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


void debounce();
uint32_t varredura(void);
void Pisca_LED(uint32_t liga);
void toggle_step_f(void);
void reset_all(void);

void step_motor(int degrees, int direction);

uint32_t mult_base;// ;R6 = base multiplicac�o
uint32_t mult;//;R7 = estado multiplicador
uint32_t new_key_det;// ;R8 = nova tecla detectada

//uint32_t deb_new_key;//; usado em Varredura
uint32_t deb_key;//;R9 = tecla contagem debounce
uint32_t deb_counter;//;R10= n estados debounce


int main(void)
{


	PLL_Init();
	SysTick_Init();
	GPIO_Init();
	reset_all();
	setup_LCD();
	Timer0A_init();
	Set_Contagem_timer(0);

	uint32_t leitura;
	uint32_t degree = 0;
	uint32_t sumDegree = 0;
	uint32_t lap = 0;

	while (1)
	{
		leitura = varredura();
		if(leitura != 0xFF){
			debounce();
			degree=processResult(leitura);
			sumDegree+=degree;
			if(sumDegree > 360){
				sumDegree-=360;
				lap++;
			}

			if (degree < 0){
				degree*=-1;
				step_motor(degree, 0);
			} else{
				step_motor(degree, 1);
			}
		}

		send_complex_comand_lcd(0x01);

		send_string_lcd(sumDegree,lap);


	}
}

uint32_t varredura(void)
{
	// Iterating over the first column
    PortM_Output(0xE0); // MOV R0, #2_11100000
    PortL_Input();
    
    if (PortL_Input() == 0xE) { // CMP R0, #2_1110
        return 1;
    } else if (PortL_Input() == 0xD) { // CMP R0, #2_1101
        return 4;
    } else if (PortL_Input() == 0xB) { // CMP R0, #2_1011
        return 7;
    } 
    
    // Iterating over the second column
    PortM_Output(0xD0); // MOV R0, #2_11010000
    PortL_Input();
    
    if (PortL_Input() == 0xE) { // CMP R0, #2_1110
        return 2;
    } else if (PortL_Input() == 0xD) { // CMP R0, #2_1101
        return 5;
    } else if (PortL_Input() == 0xB) { // CMP R0, #2_1011
        return 8;
    } else if (PortL_Input() == 0x7) { // CMP R0, #2_0111
       	return 0;
    }
    
    // Iterating over the third column
    PortM_Output(0xB0); // MOV R0, #2_10110000
    PortL_Input();
    
    if (PortL_Input() == 0xE) { // CMP R0, #2_1110
        return 3;
    } else if (PortL_Input() == 0xD) { // CMP R0, #2_1101
        return 6;
    } else if (PortL_Input() == 0xB) { // CMP R0, #2_1011
        return 9;
    } else if (PortL_Input() == 0x7) { // CMP R0, #2_0111

    }
		
		// Iterating over the fourth column
    PortM_Output(0x70); // MOV R0, #2_01110000
    PortL_Input();
    
    if (PortL_Input() == 0xE) { // CMP R0, #2_1110
        return 10;;
    } else if (PortL_Input() == 0xD) { // CMP R0, #2_1101
        return 11;
    } else if (PortL_Input() == 0xB) { // CMP R0, #2_1011
        return 12;
		}
	return 0xFF;
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


