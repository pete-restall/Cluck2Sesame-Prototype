	#include "Platform.inc"
	#include "GeneralPurposeRegisters.inc"

	radix decimal

Arithmetic32 code
	global div32x16

div32x16:
	.safelySetBankFor RBC
	movf RBC, W
	iorwf RBD, W
	btfsc STATUS, Z
	goto divideByZero

	call setCarryIfDividendMostSignificantWordIsGreaterThanDivisor
	btfsc STATUS, C
	goto overflow

	movlw 16
	movwf RZA

subtractionLoop:
	bcf STATUS, C
	rlf RAD
	rlf RAC
	rlf RAB
	rlf RAA
	btfsc STATUS, C
	goto doSubtraction

	call setCarryIfDividendMostSignificantWordIsGreaterThanDivisor
	btfss STATUS, C
	goto nextIteration

doSubtraction:
	call subtractDivisorFromDividendMostSignificantWord
	bsf RAD, W

nextIteration:
	decfsz RZA
	goto subtractionLoop

adjustFlagsAndReturn:
	bcf STATUS, C
	bcf STATUS, DC

adjustZeroFlag:
	movf RAA, W
	iorwf RAB, W
	iorwf RAC, W
	iorwf RAD, W
	return

divideByZero:
	bcf STATUS, C
	bsf STATUS, DC
	bcf STATUS, Z
	return

overflow:
	bsf STATUS, C
	bcf STATUS, DC
	bcf STATUS, Z
	return

setCarryIfDividendMostSignificantWordIsGreaterThanDivisor:
	movf RBD, W
	subwf RAB, W
	movf RBC, W
	btfss STATUS, C
	incfsz RBC, W
	subwf RAA, W
	return

subtractDivisorFromDividendMostSignificantWord:
	movf RBD, W
	subwf RAB
	movf RBC, W
	btfss STATUS, C
	incfsz RBC, W
	subwf RAA
	return

	end
