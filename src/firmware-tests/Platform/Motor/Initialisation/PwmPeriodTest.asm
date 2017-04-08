	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "TestFixture.inc"

	radix decimal

EXPECTED_15_625KHZ_PR2 equ 63

PwmPeriodTest code
	global testArrange

testArrange:
	banksel TMR0
	movf TMR0, W
	banksel PR2
	movwf PR2

testAct:
	fcall initialiseMotor

testAssert:
	.aliasForAssert PR2, _a
	.aliasLiteralForAssert EXPECTED_15_625KHZ_PR2, _b
	.assert "_a == _b, 'Expected PR2 for 15.625kHz (maximum 8-bit frequency).'"
	return

	end
