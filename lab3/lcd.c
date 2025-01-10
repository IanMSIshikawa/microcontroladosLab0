// main.c
// Desenvolvido para a placa EK-TM4C1294XL
// Verifica o estado das chaves USR_SW1 e USR_SW2, acende os LEDs 1 e 2 caso estejam pressionadas independentemente
// Caso as duas chaves estejam pressionadas ao mesmo tempo pisca os LEDs alternadamente a cada 500ms.
// Prof. Guilherme Peron

#include "lcd.h"

// -------------------------------------------------------------------------------
// Fun��o PortJ_Input
// L� os valores de entrada do port J
// Par�metro de entrada: N�o tem
// Par�metro de sa�da: o valor da leitura do port
void setup_LCD(void)
{
    //;Inicializar no modo 2 linhas / caracter matriz 5x7 (0x38)
    send_comand_lcd(0x38);

    send_complex_comand_lcd(0x0C);

    //;Cursor com autoincremento para direita (0x06)

    send_comand_lcd(0x06);

    //;Resetar: Limpar o display e levar o cursor para o home (0x01)

    send_complex_comand_lcd(0x01);

   //;Configurar o cursor (habilitar o display + cursor pisca) (0x0F) 
    send_comand_lcd(0x0F);

}

void send_comand_lcd(uint32_t cmd_var)
{
    //;pm0 -> INTRUÇÃO/DADO (0/1)
    //;pm1 -> write/read (0/1)
    //;pm2 -> enable

    //;carrega comando 
    PortK_Output(cmd_var);

    //;seta pinos pm0, pm1, pm2 para intrução, write, enable
    PortM_Output_LCD(0x04);

    //;espera por 10us
    SysTick_Wait1us(10);

    //;desabilita e espera 40us
    PortM_Output_LCD(0x00);

    SysTick_Wait1us(40);

}

void send_complex_comand_lcd(uint32_t cmd_var)
{
    //;pm0 -> INTRUÇÃO/DADO (0/1)
    //;pm1 -> write/read (0/1)
    //;pm2 -> enable

    //;carrega comando 
    PortK_Output(cmd_var);

    //;seta pinos pm0, pm1, pm2 para intrução, write, enable
    PortM_Output_LCD(0x04);

    //;espera por 10us
    SysTick_Wait1us(10);

    //;desabilita e espera 1,64ms
    PortM_Output_LCD(0x00);
    SysTick_Wait1us(1640);

}

void send_data_lcd(uint32_t cmd_var)
{
    //;pm0 -> INTRUÇÃO/DADO (0/1)
    //;pm1 -> write/read (0/1)
    //;pm2 -> enable

    //;carrega dado 
    PortK_Output(cmd_var);

    //;seta pinos pm0, pm1, pm2 para dado, write, enable
   // MOV R0, #2_101
    PortM_Output_LCD(0x05);

    //;espera por 10us
    SysTick_Wait1us(10);

    //;desabilita e espera 40us
    PortM_Output_LCD(0x00);
    SysTick_Wait1us(40);

}

void send_string_lcd(uint32_t mult1, uint32_t mult2)
{
    const char stringA[] = "Tabuada do ";
    int i = 0;
    for(i=0;stringA[i]!='\0';i++)
    {
        send_data_lcd( (uint32_t)(stringA[i]) );
    }
    send_data_lcd( (uint32_t) (mult1+'0') );
    //'\n'
    send_comand_lcd( 0xC0 );
    send_data_lcd( (uint32_t) (mult1+'0') );
    send_data_lcd( (uint32_t) ('X') );
    send_data_lcd( (uint32_t) (mult2+'0') );
    uint32_t res= mult1*mult2;
    if(res>=10)
    {
        send_data_lcd( (uint32_t) ((res/10)+'0') );
    }
    send_data_lcd( (uint32_t) ((res%10)+'0') );
}
