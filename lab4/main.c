// main.c
// Desenvolvido para a placa EK-TM4C1294XL
// Verifica o estado das chaves USR_SW1 e USR_SW2, acende os LEDs 1 e 2 caso estejam pressionadas independentemente
// Caso as duas chaves estejam pressionadas ao mesmo tempo pisca os LEDs alternadamente a cada 500ms.
// Prof. Guilherme Peron

#include <stdint.h>
#include <stdio.h>
#include <stdbool.h>
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

// void step_motor(int direction);
void vel_control();
bool UART0_Available();
void initPot();

uint32_t mult_base;// ;R6 = base multiplicac�o
uint32_t mult;//;R7 = estado multiplicador
uint32_t new_key_det;// ;R8 = nova tecla detectada

uint32_t programState = 0;
char readChar = 0;

bool direction = 0;
bool direction_target = 0;
uint32_t pwm_duty_cycle = 1;
uint32_t pwm_duty_cycle_target = 1;
bool pwm_high =  false;


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

int main(void) {
    PLL_Init();
    SysTick_Init();
    GPIO_Init();
    init_uart();
    initPot();
		Timer0A_init();
    vel_control();

    char readChar = 0;
    while (1) {
        if (programState == 0) {
            UART0_SendString("Motor parado, pressione * para iniciar.\r\n");
            while (readChar != '*') {
                readChar = UART0_ReadChar();
            }
            programState = 1;
        }

        if (programState == 1) {
            UART0_SendString("Controle por terminal (t) ou potenciômetro (p)?\r\n");
            while (readChar != 'p' && readChar != 't') {
                readChar = UART0_ReadChar();
            }
            programState = (readChar == 'p') ? 2 : 3;
        }

        if (programState == 2) { // Controle por potenciômetro
            while (programState == 2) {
                uint32_t adcValue = ADC_Read();
                pwm_duty_cycle_target = (adcValue < 2048) ? ((2048 - adcValue) * 100 / 2048) : ((adcValue - 2048) * 100 / 2048);
                uint32_t direction_target = (adcValue < 2048) ? 0 : 1;
                direction = direction_target;


                char buffer[50];
                sprintf(buffer, "pwm_duty_cycleocidade: %d%%, Direção: %s\r\n", pwm_duty_cycle_target, direction_target == 0 ? "Horário" : "Anti-horário");
                UART0_SendString(buffer);

                if (UART0_Available() && UART0_ReadChar() == 's') {
                    programState = 0;
                    pwm_duty_cycle_target = 1;
                    programState = 0;
                }
                SysTick_Wait1ms(1000);
            }
        }

        if (programState == 3) { // Controle por terminal
            UART0_SendString("Sentido horário (h) ou anti-horário (a)?\r\n");
            while (readChar != 'h' && readChar != 'a') {
                readChar = UART0_ReadChar();
            }
            direction_target = (readChar == 'h') ? 0 : 1;
            direction = direction_target;

            UART0_SendString("Selecione a pwm_duty_cycleocidade (0-9):\r\n");
            while (readChar < '0' || readChar > '9') {
                readChar = UART0_ReadChar();
            }
            pwm_duty_cycle_target = (readChar == '0') ? 100 : (readChar - '0') * 10;


            while (1) {
                char buffer[50];
                sprintf(buffer, "pwm_duty_cycleocidade: %d%%, Direção: %s\r\n", pwm_duty_cycle, direction == 0 ? "Horário" : "Anti-horário");
                UART0_SendString(buffer);

                if (UART0_Available()) {
                    readChar = UART0_ReadChar();
                    if (readChar == 'h' || readChar == 'a') {
                        direction_target = (readChar == 'h') ? 0 : 1;
                        direction = direction_target;
                    }
                    if (readChar >= '0' && readChar <= '9') {
                        pwm_duty_cycle_target = (readChar == '0') ? 100 : (readChar - '0') * 10;
                    }
                    if (readChar == 's') {
                        programState = 0;
                        pwm_duty_cycle_target = 1;
                        break;
                    }
                }
                SysTick_Wait1ms(1000);
            }
        }
    }
}






