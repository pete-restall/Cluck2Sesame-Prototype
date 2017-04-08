	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Adc.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global initialPie1
	global expectedPie1

initialPie1 res 1
expectedPie1 res 1

Pie1Test code
	global testArrange

testArrange:
	banksel initialPie1
	movf initialPie1, W
	banksel PIE1
	movwf PIE1

testAct:
	fcall initialiseAdc

testAssert:
	.aliasForAssert PIE1, _a
	.aliasForAssert expectedPie1, _b
	.assert "_a == _b, 'PIE1 expectation failure.'"
	return

	end
