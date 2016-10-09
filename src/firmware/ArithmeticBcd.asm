	#include "p16f685.inc"
	#include "GeneralPurposeRegisters.inc"
	radix decimal

NEGATIVE_9 equ (~0x09) + 1
NEGATIVE_90 equ (~0x90) + 1

ArithmeticBcd code
	global incBcd

incBcd:
	banksel RBA
	movwf RBA
	andlw 0x0f
	addlw NEGATIVE_9
	btfsc STATUS, C
	goto lsdGreaterThanOrEqualToNine
	bcf STATUS, C
	incf RBA, W
	return

lsdGreaterThanOrEqualToNine:
	movlw 0xf0
	andwf RBA, W
	movwf RBA
	addlw NEGATIVE_90
	btfsc STATUS, C
	goto overflow
	movf RBA, W
	addlw 0x10
	return

overflow:
	movlw 0x00
	bsf STATUS, Z
	bsf STATUS, C
	return

	end
