#ifndef __MOTOR__H__
#define __MOTOR__H__

#include <stdint.h>

#include "tm4c1294ncpdt.h"


void vel_control();

extern bool direction ;
extern bool direction_target;
extern uint32_t pwm_duty_cycle ;
extern uint32_t pwm_duty_cycle_target;

#endif  //!__MOTOR__H__