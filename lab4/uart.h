#ifndef __UART__H__
#define __UART__H__

#include <stdint.h>
#include <stdbool.h>

#include "tm4c1294ncpdt.h"



void init_uart();
bool UART0_Available();
void UART0_SendChar(char c);
void UART0_SendString(const char *str);
char UART0_ReadChar(void);



#endif  //!__UART__H__