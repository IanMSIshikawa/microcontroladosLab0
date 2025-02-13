#include "timer.h"


void Timer0A_init(void){
    
    SYSCTL_RCGCTIMER_R=0x01;//;Habilitar o TIMER 0 no registrador RCGCTIMER

    int wait = 0x01;
    
    while (wait==0x01)//Espera_PRTIMER
    {
        wait = SYSCTL_PRTIMER_R;
    }

    TIMER0_CTL_R=0x00;//;Desabilita TIMERS

    TIMER0_CFG_R=0x04;// ;Configura TIMER para 16 bits (com preescale)

    TIMER0_TAMR_R=0x2;//;Habilita modo periodico no TIMER A

    TIMER0_TAILR_R=CONTAGEM_1_MS;//;Habilita contador para o valor 100ms

    TIMER0_TAPR_R= CONTAGEM_PREESCALE;//;Seta preescale

    TIMER0_ICR_R=0x01;//;Limpa a interrupcao do TIMER A

    TIMER0_IMR_R=0x01;// ;Seta a interrup��o do TimerA

    NVIC_PRI4_R=( NVIC_PRI4_R | ( 0x04 << 29 ));//;Seta a prioridade do TIMER A0

    NVIC_EN0_R = ( NVIC_EN0_R | (0x01<<19));//  ;Habilita a interrupcao do TIMER A0
    
    TIMER0_CTL_R=0x01; //   ;Habilita TIMER A

}

void Timer0A_Handler(void){

    TIMER0_ICR_R=0;
    uint32_t contagem;
    if(pwm_high==0){
        contagem=((CONTAGEM_1_MS+1)*pwm_duty_cycle)/100 -1 ;
        Set_Contagem_timer(contagem);
        pwm_high=1;
    }
    else{
        contagem=((CONTAGEM_1_MS+1)*(100 - pwm_duty_cycle))/100 -1 ;
        Set_Contagem_timer(contagem);
        pwm_high=0;
    }
    //toggle_led= toggle_led ^ 0x01;
   //set_toggle_led(get_toggle_led() ^ 0x01);

}


void Set_Contagem_timer(uint32_t contagem)
{
    TIMER0_TAILR_R = contagem;
}