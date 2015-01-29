#ifndef __S3C2440_H_
#define __S3C2440_H_

#define Little_endian 

/* PLL contrl register */
#define S3C_CLOCK_POWER_BASE 0x4c000000
#define MPLLCON 0x4c000004
#define UPLLCON 0x4c000008
#define CLKCON  0x4c00000c
#define CLKSLOW 0x4c000010
#define CLKDIVN 0x4c000014
/* memory controller */

#define BWSCON   0x48000000
#define BANKCON0 0x48000004
#define BANKCON1 0x48000008
#define BANKCON2 0x4800000c
#define BANKCON3 0x48000010
#define BANKCON4 0x48000014
#define BANKCON5 0x48000018
#define BANKCON6 0x4800001c
#define BANKCON7 0x48000020

#define REFRESH  0x48000024
#define BANKSIZE 0x48000028
#define MRSRB6   0x4800002c
#define MRSRB7   0x48000030


/* UART register */
#define UART0_BASE 0x50000000
#define UART1_BASE 0x50004000
#define UART2_BASE 0x50008000

#define ULCON0  (UART0_BASE)
#define ULCON1  (UART1_BASE)
#define ULCON2  (UART2_BASE)


#define UCON0   (UART0_BASE + 0x4)
#define UCON1   (UART1_BASE + 0x4)
#define UCON2   (UART2_BASE + 0x4)

#define UFCON0   (UART0_BASE + 0x8)
#define UFCON1   (UART1_BASE + 0x8)
#define UFCON2   (UART2_BASE + 0x8)


#define UMCON0   (UART0_BASE + 0xc)
#define UMCON1   (UART1_BASE + 0xc)
#define UMCON2   (UART2_BASE + 0xc)

#define UTRSTAT0   (UART0_BASE + 0x10)
#define UTRSTAT1   (UART1_BASE + 0x10)
#define UTRSTAT2   (UART2_BASE + 0x10)

#define UERSTAT0   (UART0_BASE + 0x14)
#define UFSTAT0   (UART0_BASE + 0x18)
#define UMSTAT0   (UART0_BASE + 0x1c)

#define UERSTAT1   (UART1_BASE + 0x14)
#define UFSTAT1  (UART1_BASE + 0x18)
#define UMSTAT1   (UART1_BASE + 0x1c)

#define UERSTAT2   (UART2_BASE + 0x14)
#define UFSTAT2   (UART2_BASE + 0x18)
#define UMSTAT2   (UART2_BASE + 0x1c)

#ifdef Little_endian

#define UTXH0     (UART0_BASE + 0x20)
#define URXH0     (UART0_BASE + 0x24)

#define UTXH1     (UART1_BASE + 0x20)
#define URXH1     (UART1_BASE + 0x24)

#define UTXH2     (UART2_BASE + 0x20)
#define URXH2     (UART2_BASE + 0x24)

#else

#define UTXH0     (UART0_BASE + 0x23)
#define URXH0     (UART0_BASE + 0x27)

#define UTXH1     (UART1_BASE + 0x23)
#define URXH1     (UART1_BASE + 0x27)

#define UTXH2     (UART2_BASE + 0x23)
#define URXH2     (UART2_BASE + 0x27)

#endif

#define UBRDIV0   (UART0_BASE + 0x28)
#define UBRDIV1   (UART1_BASE + 0x28)
#define UBRDIV2   (UART2_BASE + 0x28)

#endif
