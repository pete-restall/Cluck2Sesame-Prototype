	#ifndef __CLUCK2SESAME_PLATFORM_ARITHMETIC32_INC
	#define __CLUCK2SESAME_PLATFORM_ARITHMETIC32_INC
	#include "Platform.inc"
	#include "GeneralPurposeRegisters.inc"

	radix decimal

	.module ARITHMETIC32

setupIndf macro reg
	bankisel reg
	movlw reg
	movwf FSR
	endm

loadFromIndf32Into macro dest
	.setBankFor dest
	local i = 0
	while (i < 3)
		movf INDF, W
		movwf dest + i
		incf FSR
i += 1
	endw
	movf INDF, W
	movwf dest + i
	endm

loadFrom32 macro src, dest
	setupIndf src
	loadFromIndf32Into dest
	endm

storeIntoIndf32From macro src
	.setBankFor src
	local i = 0
	while (i < 3)
		movf src + i, W
		movwf INDF
		incf FSR
i += 1
	endw
	movf src + i, W
	movwf INDF
	endm

storeInto32 macro src, dest
	setupIndf dest
	storeIntoIndf32From src
	endm

	extern add32
	extern negateA32
	extern negateB32
	extern signExtendToUpperWordA32
	extern signExtendToUpperWordB32
	extern div32x16

	#endif
