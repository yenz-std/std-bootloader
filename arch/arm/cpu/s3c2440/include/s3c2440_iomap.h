#ifndef __S3C2440_H_
#define __S3C2440_H_

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

#endif
