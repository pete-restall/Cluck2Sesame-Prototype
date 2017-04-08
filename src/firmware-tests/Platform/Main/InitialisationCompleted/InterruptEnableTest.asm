	#include "Platform.inc"
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
	.aliasForAssert INTCON, _a
	.aliasForAssert expectedIntcon, _b
	.assert "_a == _b, 'INTCON expectation failure.'"
	return

pollForWork:
	return

	end
