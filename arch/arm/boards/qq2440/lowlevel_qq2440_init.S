


.global _start

_start:
	bl _disable_wathdog
	bl _s3c2440_pll_init
	bl _s3c2440_sdram_init

	ldr sp,=(1024*4)
	bl main
