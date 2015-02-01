#include <head.h>	
.global _start
.section .text.bootm_init.text, "ax"
_start:
	bl _disable_wathdog
	bl _s3c2440_pll_init
	bl _s3c2440_sdram_init

	ldr sp,=(1024*4)
	bl nf_init
	mov r0,#0
	ldr r1,=0x30000000
	ldr r2, =2048
	bl nf_read
@	b main
	ldr sp,=(0x30000000 + 2048)
	ldr pc,=main

