#ifndef __MOTOR__H__
#define __MOTOR__H__

#include <stdint.h>

#include "tm4c1294ncpdt.h"



void step_motor(int direction);
int calcular_tempo_ms(char tecla);


#endif  //!__MOTOR__H__