#ifndef __MOTOR__H__
#define __MOTOR__H__

#include <stdint.h>
#include <stdbool.h>

#include "tm4c1294ncpdt.h"


void vel_control();

extern bool direction ;
extern bool direction_target;
extern uint32_t pwm_duty_cycle ;
extern uint32_t pwm_duty_cycle_target;

// void step_motor(int direction);
int calcular_tempo_ms(int velocidade);
void PWM_SetDutyCycle(int vel);
void vel_control();


#endif  //!__MOTOR__H__