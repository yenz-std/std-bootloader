#include "s3c2440.h"
#include "config.h"
.global _start


.global _disable_wathdog
_disable_wathdog:	
	ldr r0,=0x53000000
	mov r1,#0
	str r1,[r0]
	mov pc,lr
	
.global _s3c2440_pll_init
_s3c2440_pll_init:
	
	ldr r0,=S3C_CLOCK_POWER_BASE
	ldr r1,=BOARD_SPECIFIC_CLKDIVN
	str r1,[r0,#20]

	ldr r3,=0xFFFFFFF0     //clkcon
	str r3,[r0,#12]

	ldr r3,=0xffffffff     //locktime
	str r3,[r0]

	mrc p15, 0, r1, c1, c0, 0
	orr r1, r1, #0xc0000000
	mcr p15, 0, r1, c1, c0, 0

	/* configure UPLL */
	ldr r1, =BOARD_SPECIFIC_UPLL
	str r1, [r0, #8]

	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop

	/* configure MPLL */
	ldr r1, =BOARD_SPECIFIC_MPLL
	str r1, [r0, #4]

	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	
	mov pc, lr

.global _s3c2440_sdram_init
_s3c2440_sdram_init:
	ldr r0,=BWSCON
	ldr r1,=men_cf
	ldr r3,=0x48000034
1:
	ldr r5,[r1],#4
	str r5,[r0],#4
	cmp r0,r3
	bne 1b
	mov pc, lr

men_cf:
	.word  ((0x3 << 28) | (0x2 << 24) | 0x333330)
	.word  0x00000700
	.word  0x00000700
	.word  0x00000700
	.word  0x00000700
	.word  0x00000700
	.word  0x00000700
	.word  0x00018005
	.word  0x00018005
	.word  ((0x1 << 23) | (0x0 << 22) | (0x0 << 20) | (0x1 << 18) | 1269)
	.word  ((0x1 << 7) | (0x1 << 5) | (0x1 << 4) | 0x1)
	.word  (0x2 << 4)
	.word  0x0
	
	

	
	
_start:
	bl _disable_wathdog
	
	bl _s3c2440_pll_init

	ldr sp,=(1024*4)
	
	bl  init_led
	
        ldr r0,=0x5
	
	bl led_on
	
	bl _s3c2440_sdram_init

	ldr r0,=0x6
	bl led_on
	
        ;; ldr sp,=(1024*4)
	;; push {lr}
	;; bl main
	
halt:
	b halt
