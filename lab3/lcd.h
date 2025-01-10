#ifndef __LCD__H__
#define __LCD__H__

#include <stdint.h>

#include "tm4c1294ncpdt.h"

void setup_LCD(void);

void send_comand_lcd(uint32_t cmd_var);

void send_complex_comand_lcd(uint32_t cmd_var);

void send_data_lcd(uint32_t cmd_var);

void send_string_lcd(uint32_t mult1, uint32_t mult2);


#endif  //!__LCD__H__