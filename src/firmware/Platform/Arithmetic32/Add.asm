	#include "Platform.inc"
	#include "GeneralPurposeRegisters.inc"

	radix decimal

Arithmetic32 code
	global add32

add32:
add32LeastSignificantByte:
	.safelySetBankFor RBD
	movf RBD, W
	addwf RAD

add32NextLeastSignificantByte:
	movf RBC, W
	btfsc STATUS, C
	incfsz RBC, W
	addwf RAC

add32NextMostSignificantByte:
	movf RBB, W
	btfsc STATUS, C
	incfsz RBB, W
	addwf RAB

addMostSignificantByte:
	movf RBA, W
	btfsc STATUS, C
	incfsz RBA, W
	addwf RAA

adjustZero:
	movf RAA, W
	iorwf RAB, W
	iorwf RAC, W
	iorwf RAD, W
	return

	end
