	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global expectedPORTC
	global expectedTRISC

expectedPORTC res 1
expectedTRISC res 1

PortcTest code
	global testArrange

testArrange:
	banksel ANSEL
	clrf ANSEL

	banksel ANSELH
	clrf ANSELH

testAct:
	fcall initialiseMotor

testAssert:
	.assert "portc == expectedPORTC, 'PORTC expectation failure.'"
	.assert "trisc == expectedTRISC, 'TRISC expectation failure.'"
	return

	end
