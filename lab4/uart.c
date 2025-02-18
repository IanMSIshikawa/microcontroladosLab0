#include "uart.h"
#include <stdbool.h>

void init_uart(){
    SYSCTL_RCGCUART_R |= 0x01; //ativa uart0
    while((SYSCTL_PRUART_R & 0x01) != 0x01 ){};

    UART0_CTL_R &= ~0x01;
    
    // Configura baud rate (IBRD + FBRD) para 115200
    UART0_IBRD_R = 260;  // Parte inteira do divisor
    UART0_FBRD_R = 27; // Parte fracionária
    
    //Configura UART para 8 bits, sem paridade, 1 stop bit (8N1)
    UART0_LCRH_R = (0x3 << 5);  // 8 bits de dados, FIFO desativado

    UART0_CC_R = 0x0; // Usa o clock do sistema
    
    //Habilita o UART0 novamente
    UART0_CTL_R |= 0x301; // Habilita UART, RX e TX
}

void UART0_SendChar(char c) {
    while (UART0_FR_R & (1 << 5)); // Aguarda enquanto TX FIFO está cheio
    UART0_DR_R = c; // Escreve o caractere no registrador de dados
}

// Função para enviar uma string
void UART0_SendString(const char *str) {
    while (*str) {
        UART0_SendChar(*str++);
    }
}

// Função para receber um caractere pela UART0
char UART0_ReadChar(void) {
    while (UART0_FR_R & (1 << 4)); // Aguarda até que RX FIFO tenha dados
    return (char)UART0_DR_R; // Retorna o caractere recebido
}

// Função para verificar se há um caractere disponível na UART
bool UART0_Available() {
    return !(UART0_FR_R & 0x10);
}