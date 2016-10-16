	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
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
	fcall initialiseMotor

testAssert:
	.assert "ansel == expectedANSEL, 'ANSEL expectation failure.'"
	.assert "anselh == expectedANSELH, 'ANSELH expectation failure.'"
	return

	end
