#ifndef __TIMER__H__
#define __TIMER__H__

#include <stdint.h>

#include "tm4c1294ncpdt.h"


void Timer0A_init(void){
    SYSCTL_RCGCTIMER_R
}

#endif  //!__TIMER__H__