	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "GeneralPurposeRegisters.inc"
	#include "Arithmetic4.inc"

	radix decimal

ArithmeticBcd code
	global binaryToBcd

binaryToBcd:
	.safelySetBankFor RAA
	swapf RAA, W
	addwf RAA, W
	andlw b'00001111'

	btfsc STATUS, DC
	addlw 0x16
	btfsc STATUS, DC
	addlw 0x06

	addlw 0x06
	btfss STATUS, DC
	addlw -0x06

	btfsc RAA, 4
	addlw 0x16 - 1 + 0x06
	btfss STATUS, DC
	addlw -0x06

	btfsc RAA, 5
	addlw 0x30

	btfsc RAA, 6
	addlw 0x60

	btfsc RAA, 7
	addlw 0x20

	addlw 0x60
	btfsc STATUS, C
	goto overflowedTensPastNine

notOverflowedTensPastNine:
	addlw -0x60
	bcf STATUS, C
	btfsc RAA, 7

overflowedTensPastNine:
	bsf STATUS, C
	return

	end
