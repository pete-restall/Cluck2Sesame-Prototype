	#include "Mcu.inc"
	#include "GeneralPurposeRegisters.inc"

	radix decimal

Arithmetic32 code
	global add32

add32:
add32LeastSignificantByte:
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
	movf RAA
	btfss STATUS, Z
	return

	movf RAB
	btfss STATUS, Z
	return

	movf RAC
	btfss STATUS, Z
	return

	movf RAD
	return

	end
