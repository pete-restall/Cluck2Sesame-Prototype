	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "ShiftRegister.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global expectedANSEL
	global expectedANSELH

expectedANSEL res 1
expectedANSELH res 1

AnselTest code
	global testArrange

testArrange:

testAct:
	fcall initialiseShiftRegister

testAssert:
	.aliasForAssert ANSEL, _a
	.aliasForAssert expectedANSEL, _b
	.assert "_a == _b, 'ANSEL expectation failure.'"

	.aliasForAssert ANSELH, _a
	.aliasForAssert expectedANSELH, _b
	.assert "_a == _b, 'ANSELH expectation failure.'"
	return

	end
