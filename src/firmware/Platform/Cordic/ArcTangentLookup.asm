	#define __CLUCK2SESAME_PLATFORM_CORDIC_ARCTANGENTLOOKUP_ASM

	#include "Mcu.inc"
	#include "Cordic.inc"

	radix decimal

	#if NUMBER_OF_ITERATIONS != 15
	error "Expected 15 CORDIC iterations - review this lookup !"
	#endif

Cordic code
	global arcTangentLookup

arcTangentLookup:
	dw 0x2000
	dw 0x12e4
	dw 0x09fc
	dw 0x0512
	dw 0x028c
	dw 0x0146
	dw 0x00a4
	dw 0x0052
	dw 0x002a
	dw 0x0014
	dw 0x000a
	dw 0x0006
	dw 0x0004
	dw 0x0002
	dw 0x0002

	end
