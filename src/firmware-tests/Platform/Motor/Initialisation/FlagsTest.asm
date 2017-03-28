	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "TestFixture.inc"

	radix decimal

FlagsTest code
	global testArrange

testArrange:

testAct:
	fcall initialiseMotor

testAssert:
	banksel motorFlags
	.assert "motorFlags == 0, 'Expected motorFlags to be cleared.'"
	return

	end
