#include <head.h>	
.global _start
.section .text.bootm_init.text, "ax"
_start:
	bl _disable_wathdog
	bl _s3c2440_pll_init
	bl _s3c2440_sdram_init

        ldr sp,=(0x30000000 + 2048 * 10)
	
	adr r0,_start
	ldr r1,=_start
	cmp r0,r1
	beq on_sdram

	bl nf_init

	mov r0,#0
	ldr r1,=0x30000000
	ldr r3,=_scopy
	ldr r4,=_ecopy
	sub r2, r4,r3
	bl nf_read

	ldr r0,=_sbss
	ldr r1,=_ebss
	cmp r0,r1
	beq on_sdram

	mov r2,#0
1:	
	str r2,[r0],#4
	cmp r0,r1
	bne 1b

	
on_sdram:	
	ldr pc,=main
	
