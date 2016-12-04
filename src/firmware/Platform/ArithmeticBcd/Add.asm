	#include "Mcu.inc"
	#include "GeneralPurposeRegisters.inc"

	radix decimal

NEGATIVE_10 equ (~0x0a) + 1
NEGATIVE_100 equ (~0xa0) + 1

ArithmeticBcd code
	global addBcd

addBcd:
	movf RBA, W
	addwf RAA

addCheckForLsdOverflow:
	movlw 0x0f
	andwf RAA, W
	addlw NEGATIVE_10
	btfss STATUS, C
	goto addCheckForMsdOverflow

addLsdOverflowed:
	movlw 10
	subwf RAA
	movlw 0x10
	addwf RAA

addCheckForMsdOverflow:
	movlw 0xf0
	andwf RAA, W
	addlw NEGATIVE_100
	btfsc STATUS, C
	goto addMsdOverflowed

addAdjustZeroAfterNoOverflow:
	movf RAA
	return

addMsdOverflowed:
	movlw 0xa0
	subwf RAA

addAdjustZeroAfterOverflow:
	movf RAA
	return

	end
