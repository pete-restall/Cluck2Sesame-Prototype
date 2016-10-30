	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Smps.inc"
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
	fcall initialiseSmps

testAssert:
	.aliasForAssert PORTC, _a
	.aliasForAssert expectedPORTC, _b
	.assert "_a == _b, 'PORTC expectation failure.'"

	.aliasForAssert TRISC, _a
	.aliasForAssert expectedTRISC, _b
	.assert "_a == _b, 'TRISC expectation failure.'"
	return

	end
