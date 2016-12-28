	#ifndef __CLUCK2SESAME_PLATFORM_CORDIC_INC
	#define __CLUCK2SESAME_PLATFORM_CORDIC_INC
	#include "GeneralPurposeRegisters.inc"

loadCordicArgument macro arg
	banksel arg
	movf arg, W
	banksel cordicArgumentHigh
	movwf cordicArgumentHigh

	banksel arg
	movf arg + 1, W
	banksel cordicArgumentLow
	movwf cordicArgumentLow
	endm

loadSineArgument macro phi
	loadCordicArgument phi
	endm

	extern cordicArgument
	extern cordicArgumentHigh
	extern cordicArgumentLow

	extern cordicResult
	extern cordicResultHigh
	extern cordicResultLow

	extern initialiseCordic
	extern pollCordic
	extern isCordicIdle
	extern sine

	#endif
