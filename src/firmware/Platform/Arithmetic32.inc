	#ifndef __CLUCK2SESAME_PLATFORM_ARITHMETIC32_INC
	#define __CLUCK2SESAME_PLATFORM_ARITHMETIC32_INC
	#include "GeneralPurposeRegisters.inc"

loadFrom32 macro src, dest
	bankisel dest
	movlw dest
	movwf FSR

	banksel src
	local i = 0
	while (i < 4)
		movf src + i, W
		movwf INDF
		incf FSR
i += 1
	endw
	endm

storeInto32 macro src, dest
	loadFrom32 src, dest
	endm

	extern add32
	extern negateA32
	extern negateB32
	extern signExtendToUpperWordA32
	extern signExtendToUpperWordB32

	#endif
