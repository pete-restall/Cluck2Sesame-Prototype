	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Timer0.inc"
	#include "TestFixture.inc"
	#include "../InitialiseAfterTimer0Mock.inc"

	radix decimal

	udata
	global initialOptionReg
	global initialT0If
	global expectedOptionReg

initialOptionReg res 1
initialT0If res 1
expectedOptionReg res 1

InitialiseTimer0Test code
	global testArrange

testArrange:
	banksel initialOptionReg
	movf initialOptionReg, W
	banksel OPTION_REG
	movwf OPTION_REG

	banksel initialT0If
	movf initialT0If
	banksel INTCON
	bcf INTCON, T0IF
	btfss STATUS, Z
	bsf INTCON, T0IF

	fcall initialiseInitialiseAfterTimer0Mock

testAct:
	fcall initialiseTimer0

testAssert:
	.aliasForAssert TMR0, _a
	.assert "_a == 0, 'Expected TMR0 == 0.'"

	banksel INTCON
	clrw
	btfsc INTCON, T0IF
	movlw 0xff
	.aliasWForAssert _a
	.assert "_a == 0, 'Expected T0IF to be cleared.'"

	.aliasForAssert OPTION_REG, _a
	.aliasForAssert expectedOptionReg, _b
	.assert "_a == _b, 'OPTION_REG expectation failure.'"
	return

	end
