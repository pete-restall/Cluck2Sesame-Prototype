	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Adc.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global initialPir1
	global expectedPir1

initialPir1 res 1
expectedPir1 res 1

Pir1Test code
	global testArrange

testArrange:
	banksel initialPir1
	movf initialPir1, W
	banksel PIR1
	movwf PIR1

testAct:
	fcall initialiseAdc

testAssert:
	.aliasForAssert PIR1, _a
	.aliasForAssert expectedPir1, _b
	.assert "_a == _b, 'PIR1 expectation failure.'"
	return

	end
