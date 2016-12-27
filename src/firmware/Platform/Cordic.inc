	#ifndef __CLUCK2SESAME_PLATFORM_CORDIC_INC
	#define __CLUCK2SESAME_PLATFORM_CORDIC_INC
	#include "GeneralPurposeRegisters.inc"

loadCordicArgument macro arg
	banksel arg
	movf arg, W
	banksel RBC
	movwf RBC

	banksel arg
	movf arg + 1, W
	banksel RBD
	movwf RBD
	endm

loadSineArgument macro phi
	loadCordicArgument phi
	endm

	extern cordicResult
	extern cordicResultHigh
	extern cordicResultLow

	extern initialiseCordic
	extern pollCordic
	extern isCordicIdle
	extern sine

	#endif
