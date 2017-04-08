	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global expectedPORTA
	global expectedTRISA

expectedPORTA res 1
expectedTRISA res 1

PortaTest code
	global testArrange

testArrange:
	banksel ANSEL
	clrf ANSEL

	banksel ANSELH
	clrf ANSELH

testAct:
	fcall initialiseLcd

testAssert:
	.aliasForAssert PORTA, _a
	.aliasForAssert expectedPORTA, _b
	.assert "_a == _b, 'PORTA expectation failure.'"

	.aliasForAssert TRISA, _a
	.aliasForAssert expectedTRISA, _b
	.assert "_a == _b, 'TRISA expectation failure.'"
	return

	end
