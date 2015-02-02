#include <head.h>	
.global _start
.section .text.bootm_init.text, "ax"
_start:
	bl _disable_wathdog
	bl _s3c2440_pll_init
//	bl _s3c2440_sdram_init

	ldr r0,=0x56000010
	ldr r1,=0x15400
	str r1,[r0]
	ldr r0,=0b100000
	ldr r1,=0x56000014
	str r0,[r1]
@        ldr sp,=(0x30000000 + 2048)
	ldr sp,=(1024*4)
@	bl init_led
@	mov r0,#5
@	bl led_on
	
	bl nf_init
	mov r0,#6
	bl led_on
	mov r0,#0
	ldr r1,=0x30001000
	ldr r2, =4096
	bl nf_read
	mov r0,#7
	bl led_on
	
	adr r0,_start
	ldr r1,=_start
	
	cmp r0,r1
	beq led_on_8 
led_off_5:
	mov r0,#5
	bl led_off
led_on_8:	
	mov r0,#8
	bl led_on

	ldr r0,=0x0
	ldr r1,=0x800
	ldr r2,=_scopy
	ldr r3,=_ecopy
	sub r4,r3,r2
1:	
	ldr r5,[r0],#4
	str r5,[r1],#4
	cmp r0,r4
	bne 1b
	
   # bl main
	
	ldr pc,=main
	
