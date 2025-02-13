#include "motor.h"

#define PASSOS_POR_VOLTA 2048
#define TEMPO_MIN_MS 2   // Tempo mínimo entre passos (máxima velocidade)
#define TEMPO_MAX_MS 50  // Tempo máximo entre passos (velocidade mais lenta)

// Funções externas
extern void SysTick_Wait1ms(int delay);
extern void SysTick_Wait1us(int delay);
void PortH_Output(uint32_t valor);

// Array de passos para controle do motor
uint32_t passos[4] = {0x01, 0x02, 0x04, 0x08};

int calcular_tempo_ms(int velocidade) {
    if (velocidade < 0) velocidade = 0;
    if (velocidade > 100) velocidade = 100;
    
    return TEMPO_MAX_MS - (velocidade * (TEMPO_MAX_MS - TEMPO_MIN_MS) / 100);
}

// Função para girar o motor indefinidamente na velocidade e direção especificada
void step_motor(int direction) {
    int i = 0;

    while (1) {  // Loop infinito para rodar continuamente


        // Define o próximo passo conforme a direção
        if (direction == 1) {  // Sentido horário
            PortH_Output(passos[i % 4]);
        } else {  // Sentido anti-horário
            PortH_Output(passos[3 - (i % 4)]);
        }

        i++;  // Avança um passo no motor

        // Aguarda conforme a velocidade definida
        SysTick_Wait1ms(10);
    }
}

int PWM_SetDutyCycle(int vel){
    if (vel < 0) vel = 0;
    if (vel > 100) vel = 100;
    
    // Calcula o valor do PWM conforme a velocidade
    uint32_t pwm = (vel * 1023) / 100;
    
    // Configura o PWM
    PWM0_0_CMPA_R = pwm;
    
    return vel;
}

