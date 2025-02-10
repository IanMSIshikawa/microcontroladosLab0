#include "uart.h"

void init_uart(){
    UART0_CTL_R &= ~0x01;
    
    // Configura baud rate (IBRD + FBRD) para 115200
    uint32_t brd = 16000000 / (16 * 115200); // IBRD = int(16MHz / (16 * Baud Rate))
    UART0_IBRD_R = brd;  // Parte inteira do divisor
    UART0_FBRD_R = ((16000000 % (16 * 115200)) * 64 + (115200 / 2)) / 115200; // Parte fracionária
    
    // 5️⃣ Configura UART para 8 bits, sem paridade, 1 stop bit (8N1)
    UART0_LCRH_R = (0x3 << 5);  // 8 bits de dados, FIFO desativado
    
    // 6️⃣ Habilita o UART0 novamente
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