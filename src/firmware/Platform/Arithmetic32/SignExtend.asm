	#include "Platform.inc"
	#include "GeneralPurposeRegisters.inc"

	radix decimal

Arithmetic32 code
	global signExtendToUpperWordA32
	global signExtendToUpperWordB32

signExtendToUpperWord32 macro reg
	.safelySetBankFor reg
	movlw 0x00
	btfsc reg + 2, 7
	movlw 0xff

	movwf reg + 0
	movwf reg + 1
	endm

signExtendToUpperWordA32:
	signExtendToUpperWord32 RAA
	return

signExtendToUpperWordB32:
	signExtendToUpperWord32 RBA
	return

	end

