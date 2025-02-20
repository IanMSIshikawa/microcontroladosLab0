#ifndef __TIMER__H__
#define __TIMER__H__

#include <stdint.h>
#include <stdbool.h>

#include "tm4c1294ncpdt.h"


#define CONTAGEM_100_MS     7999999
#define CONTAGEM_200_MS     15999999
#define CONTAGEM_300_MS     23999999
#define CONTAGEM_400_MS     31999999
#define CONTAGEM_500_MS     39999999
#define CONTAGEM_600_MS     47999999
#define CONTAGEM_700_MS     55999999
#define CONTAGEM_800_MS     63999999
#define CONTAGEM_900_MS     71999999


<<<<<<< HEAD
#define CONTAGEM_PREESCALE (79)//80-1//10 us
#define CONTAGEM_1_MS				(999)//1000-1//1% de resolucao
=======
#define CONTAGEM_PREESCALE          (79)    //80-1//10 us
#define CONTAGEM_1_MS				(999)     //1000-1//1% de resolucao
>>>>>>> 5fc7c74bf21a4231f041b121d72a61886602aec1

//ADDRESS_MEMORY_CONTAGEM EQU 0x20001000
//ADDRESS_MEMORY_OFFSET   EQU 0x04

//ADDRESS_MEMORY_TMP EQU 0x20001A00

extern uint32_t pwm_duty_cycle;
extern bool pwm_high;
extern bool direction;

void Timer0A_Handler(void);
void Timer0A_init(void);


#endif  //!__TIMER__H__