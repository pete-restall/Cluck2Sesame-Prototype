	#include "Platform.inc"
	#include "GeneralPurposeRegisters.inc"

	radix decimal

Arithmetic16 code
	global mul16x16

mul16x16:
	.safelySetBankFor RAA
	clrf RAA
	clrf RAB
	clrf RAC
	clrf RAD
	bsf RAC, 7

mul16x16_1:
	rrf RBC
	rrf RBD
	btfss STATUS, C
	goto mul16x16_2
	movf RBB, W
	addwf RAB
	movf RBA, W
	btfsc STATUS, C
	incfsz RBA, W
	addwf RAA

mul16x16_2:
	rrf RAA
	rrf RAB
	rrf RAC
	rrf RAD
	btfss STATUS, C
	goto mul16x16_1

	return

	end
