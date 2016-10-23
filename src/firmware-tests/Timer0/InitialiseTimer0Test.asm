	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Timer0.inc"
	#include "TestFixture.inc"
	#include "InitialiseAfterTimer0Mock.inc"

	radix decimal

	udata
	global expectedOptionReg

expectedOptionReg res 1

InitialiseTimer0Test code
	global testArrange

testArrange:
	fcall initialiseInitialiseAfterTimer0Mock

testAct:
	fcall initialiseTimer0

testAssert:
	.assert "option_reg == expectedOptionReg, 'OPTION_REG expectation failure.'"
	return

	end
