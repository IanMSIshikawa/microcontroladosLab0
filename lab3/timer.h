#ifndef __TIMER__H__
#define __TIMER__H__

#include <stdint.h>

#include "tm4c1294ncpdt.h"


//extern uint32_t toggle_led ;//= 0x00;
uint32_t toggle_led ;//= 0x00;

#define CONTAGEM_100_MS     7999999
#define CONTAGEM_200_MS     15999999
#define CONTAGEM_300_MS     23999999
#define CONTAGEM_400_MS     31999999
#define CONTAGEM_500_MS     39999999
#define CONTAGEM_600_MS     47999999
#define CONTAGEM_700_MS     55999999
#define CONTAGEM_800_MS     63999999
#define CONTAGEM_900_MS     71999999

//ADDRESS_MEMORY_CONTAGEM EQU 0x20001000
//ADDRESS_MEMORY_OFFSET   EQU 0x04

//ADDRESS_MEMORY_TMP EQU 0x20001A00

//extern uint32_t contagem ;

void set_toggle_led(uint32_t led){
    toggle_led = led;
}

uint32_t get_toggle_led(void){
    return(toggle_led);
}

void Timer0A_init(void){
    
    SYSCTL_RCGCTIMER_R=0x01;//;Habilitar o TIMER 0 no registrador RCGCTIMER

    int wait = 0x01;
    
    while (wait==0x01)//Espera_PRTIMER
    {
        wait = SYSCTL_PRTIMER_R;
    }

    TIMER0_CTL_R=0x00;//;Desabilita TIMERS

    TIMER0_CFG_R=0x00;// ;Configura TIMER para 32 bits

    TIMER0_TAMR_R=0x2;//;Habilita modo periodico no TIMER A

    TIMER0_TAILR_R=7999999;//;Habilita contador para o valor 100ms

    TIMER0_TAPR_R=0x00;//;Limpa o preescale (zerado)

    TIMER0_ICR_R=0x01;//;Limpa a interrupcao do TIMER A

    TIMER0_IMR_R=0x01;// ;Seta a interrup��o do TimerA

    NVIC_PRI4_R=( NVIC_PRI4_R | ( 0x04 << 29 ));//;Seta a prioridade do TIMER A0

    NVIC_EN0_R = ( NVIC_EN0_R | (0x01<<19));//  ;Habilita a interrupcao do TIMER A0
    
    TIMER0_CTL_R=0x01; //   ;Habilita TIMER A

}

void Timer0A_Handler(void){

    TIMER0_ICR_R=0x01;

    //toggle_led= toggle_led ^ 0x01;
   set_toggle_led(get_toggle_led() ^ 0x01);

}

void Load_Contagem_Memoria(void)
{

}

void Set_Contagem_timer(uint32_t index)
{
    uint32_t contagem=CONTAGEM_100_MS;
    if(index==1){
        contagem=CONTAGEM_100_MS;
    }
    if(index==2){
        contagem=CONTAGEM_200_MS;
    }
    if(index==3){
        contagem=CONTAGEM_300_MS;
    }
    if(index==4){
        contagem=CONTAGEM_400_MS;
    }
    if(index==5){
        contagem=CONTAGEM_500_MS;
    }
    if(index==6){
        contagem=CONTAGEM_600_MS;
    }
    if(index==7){
        contagem=CONTAGEM_700_MS;
    }
    if(index==8){
        contagem=CONTAGEM_800_MS;
    }
    if(index==9){
        contagem=CONTAGEM_900_MS;
    }

    TIMER0_TAILR_R=contagem;
}

#endif  //!__TIMER__H__