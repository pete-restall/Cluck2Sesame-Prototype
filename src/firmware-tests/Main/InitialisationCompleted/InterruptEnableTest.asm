	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "TestFixture.inc"

	radix decimal

	extern initialisationCompleted

	udata
expectedIntcon res 1

InterruptEnableTest code
	global testArrange
	global pollForWork

testArrange:

testAct:
	fcall initialisationCompleted

testAssert:
	.assert "intcon == expectedIntcon, 'INTCON expectation failure.'"
	return

pollForWork:
	return

	end
