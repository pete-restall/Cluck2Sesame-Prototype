	#define __CLUCK2SESAME_PLATFORM_CORDIC_RESULTSTORAGE_ASM

	#include "Mcu.inc"
	#include "Cordic.inc"

	radix decimal

	udata
	global cordicResult
	global cordicResultHigh
	global cordicResultLow

cordicResult:
cordicResultHigh res 1
cordicResultLow res 1

	end
