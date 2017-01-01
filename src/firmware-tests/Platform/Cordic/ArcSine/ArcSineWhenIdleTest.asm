	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Cordic.inc"
	#include "TestFixture.inc"

	radix decimal

ArcSineWhenIdleTest code
	global testArrange

testArrange:
	fcall initialiseCordic

testAct:
	fcall arcSine

testAssert:
	.assert "W != 0, 'Expected W != 0.'"

	fcall isCordicIdle
	.assert "W == 0, 'Expected isCordicIdle() to return false.'"
	return

	end
