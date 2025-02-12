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
#include "uart.h"

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
void init_uart();
void UART0_SendChar(char c);
void UART0_SendString(const char *str);
char UART0_ReadChar(void);


void debounce();
uint32_t varredura(void);

void step_motor(int degrees, int direction);
void initPot();

uint32_t mult_base;// ;R6 = base multiplicac�o
uint32_t mult;//;R7 = estado multiplicador
uint32_t new_key_det;// ;R8 = nova tecla detectada


int main(void)
{

	PLL_Init();
	SysTick_Init();
	GPIO_Init();
	init_uart();
	initPot();


	uint32_t programState = 0;
	char readChar = 0;
	uint32_t direction = 0;
	uint32_t vel = 0;
	step_motor(0, 0);

	while (1)
	{
		if (programState == 0){
			const char string[] = "Motor parado, pressione * para iniciar.";
			UART0_SendString(string);
			while (!readChar)
			{
				readChar = UART0_ReadChar();
				programState = 1;
			}
			
		}
		if(programState == 1){
			const char string[] = "terminal (t) ou potenciometro (p) ? ";
			UART0_SendString(string);
			while(readChar != 'p' && readChar != 't'){
				readChar = UART0_ReadChar();
				if(readChar == 'p'){programState = 2;}
				if(readChar == 't'){programState = 3;}
			}
		}
		if (programState == 2){//controle por terminal

			const char string[] = "sentido horário (h) ou anti-horário (a) ?";
			UART0_SendString(string);
			while(readChar != 'h' && readChar != 'a'){
				readChar = UART0_ReadChar();
				if(readChar == 'h'){direction = 1;}
				if(readChar == 't'){direction = 0;}
			}

			const char string[] = "selecione a velocidade";
			UART0_SendString(string);
			while(readChar < '0' || readChar > '9'){
				readChar = UART0_ReadChar();
			}
			vel = (readChar == '0') ? 100 : (readChar - '0') * 10;
			step_motor(vel, direction);
			
			while (1) {
                char buffer[50];
                sprintf(buffer, "Velocidade: %d%%, Direção: %s\r\n",
                        vel, direction == 0 ? "Horário" : "Anti-horário");
                UART0_SendString(buffer);
                
                // Verifica se o usuário quer mudar algo
                if (UART0_Available()) {
                    readChar = UART0_ReadChar();
                    if (readChar == 'h') {
						direction = 0;
						step_motor(vel, direction);
					}
                    if (readChar == 'a') {
						direction = 1;
						step_motor(vel, direction);
					}
                    if (readChar >= '5' && readChar <= '9') {
						vel = (readChar - '0') * 10;
						step_motor(vel, direction);
					}
					if (readChar == '0') {
						vel = 100;
						step_motor(vel, direction);
					}
                    if (readChar == 's') {
                        programState = 0;
						vel = 0;
						step_motor(vel, direction);
                        break;
                    }
                }

                SysTick_Wait1ms(1000); 
            }
			

		}
		if (programState == 3){//controle por potenciometro

		}
	}
}

uint32_t ADC_Read(void) {
    // Passo 2: Iniciar a conversão manual (gatilho SW)
    ADC0_PSSI_R = ADC_PSSI_SS0;  // Aciona a conversão para SS0 (sequenciador 0)
    
    // Passo 3: Esperar a conversão ser concluída (polling de ADCRIS)
    while ((ADC0_RIS_R & ADC_RIS_INR0) == 0) {
        // Espera até que a conversão para o sequenciador SS0 esteja completa
    }
    
    // Passo 4: Ler o resultado da conversão do FIFO
    uint32_t adcResult = ADC0_SSFIFO0_R;  // Lê o valor convertido
    
    // Passo 5: Limpar a flag de conversão (ACK)
    ADC0_ISC_R = ADC_ISC_IN0;  // Limpa o bit de interrupção para SS0
    
    // Passo 6: Retornar o valor lido
    return adcResult;
}




