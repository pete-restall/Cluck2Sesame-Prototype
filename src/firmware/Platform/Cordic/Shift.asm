	#define __CLUCK2SESAME_PLATFORM_CORDIC_SHIFT_ASM

	#include "Mcu.inc"
	#include "Cordic.inc"

	radix decimal

Cordic code
	global shiftCordicWByIterationNumber

shiftCordicWByIterationNumber:
	banksel cordicIterationNumber
	incf cordicIterationNumber, W

loop:
	addlw -1
	btfsc STATUS, Z
	return

arithmeticShiftRight:
	btfss cordicWUpperHigh, 7
	bcf STATUS, C

	rrf cordicWUpperHigh
	rrf cordicWUpperLow
	rrf cordicWLowerHigh
	rrf cordicWLowerLow
	goto loop

	end
