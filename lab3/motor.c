#include "motor.h"

#define PASSOS_POR_VOLTA 2048

// Declare the assembly functions
extern void SysTick_Wait1ms(int delay);
extern void SysTick_Wait1us(int delay);

void step_motor(int degrees, int direction) {
    int passos_necessarios = (PASSOS_POR_VOLTA * degrees) / 360;  // Converte graus para passos

    for (int i = 0; i < passos_necessarios; i++) {
        if (direction == 1) {  // Sentido horário
            GPIO_PORTA_AHB_DATA = passos[i % 4];
        } else {  // Sentido anti-horário
            GPIO_PORTA_AHB_DATA = passos[3 - (i % 4)];
        }
        SysTick_Wait1ms(5);  // Ajuste para controlar a velocidade
    }
}