	#include "p16f685.inc"
	radix decimal

	extern RAA
	extern RAB
	extern RAC
	extern RAD
	extern RBA
	extern RBB
	extern RBC
	extern RBD

	udata
statusMask res 1

Arithmetic32 code
	global add32

add32:
	banksel statusMask
	movlw -1
	movwf statusMask

add32LeastSignificantByte:
	movf RBD, W
	addwf RAD
	btfss STATUS, Z
	bcf statusMask, Z

add32NextLeastSignificantByte:
	movf RBC, W
	btfsc STATUS, C
	incfsz RBC, W
	addwf RAC
	btfss STATUS, Z
	bcf statusMask, Z

add32NextMostSignificantByte:
	movf RBB, W
	btfsc STATUS, C
	incfsz RBB, W
	addwf RAB
	btfss STATUS, Z
	bcf statusMask, Z

addMostSignificantByte:
	movf RBA, W
	btfsc STATUS, C
	incfsz RBA, W
	addwf RAA
	btfss STATUS, Z
	bcf statusMask, Z

adjustZero:
	bcf STATUS, Z
	btfsc statusMask, Z
	bsf STATUS, Z
	return

	end
