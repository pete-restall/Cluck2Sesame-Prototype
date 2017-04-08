	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Timer0.inc"
	#include "TestFixture.inc"
	#include "InitialiseAfterTimer0Mock.inc"

	radix decimal

	udata
	global initialOptionReg
	global expectedOptionReg

initialOptionReg res 1
expectedOptionReg res 1

InitialiseTimer0Test code
	global testArrange

testArrange:
	banksel initialOptionReg
	movf initialOptionReg, W
	banksel OPTION_REG
	movwf OPTION_REG

	fcall initialiseInitialiseAfterTimer0Mock

testAct:
	fcall initialiseTimer0

testAssert:
	.aliasForAssert OPTION_REG, _a
	.aliasForAssert expectedOptionReg, _b
	.assert "_a == _b, 'OPTION_REG expectation failure.'"
	return

	end
