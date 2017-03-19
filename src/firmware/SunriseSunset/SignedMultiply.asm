	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Arithmetic16.inc"
	#include "Arithmetic32.inc"

	radix decimal

SunriseSunset code
	global muls16x16

; TODO: MOVE THIS INTO Arithmetic16 AND COMPREHENSIVELY TEST IT...
muls16x16:
twosComplementOnAccumulatorForNegativeArgument:
	banksel RBA
	movf RBA, W
	xorwf RBC, W

absoluteValueOfFirstOperand:
	btfss RBA, 7
	goto absoluteValueOfSecondOperand
	comf RBA
	comf RBB
	incfsz RBB
	goto $ + 2
	incf RBA

absoluteValueOfSecondOperand:
	btfss RBC, 7
	goto multiplication
	comf RBC
	comf RBD
	incfsz RBD
	goto $ + 2
	incf RBC

multiplication:
	andlw b'10000000'
	btfss STATUS, Z
	goto multiplicationOfDifferentSigns

multiplicationOfSameSigns:
	fcall mul16x16
	return

multiplicationOfDifferentSigns:
	fcall mul16x16
	fcall negateA32
	return

	end
