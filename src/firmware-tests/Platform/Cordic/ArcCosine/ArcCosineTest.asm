	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Cordic.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global cosPhiHigh
	global cosPhiLow
	global expectedCordicResultHigh
	global expectedCordicResultLow

cosPhi:
cosPhiHigh res 1
cosPhiLow res 1

expectedCordicResultHigh res 1
expectedCordicResultLow res 1

ArcCosineTest code
	global testArrange

testArrange:
	fcall initialiseCordic

testAct:
	loadArcCosineArgument cosPhi
	fcall arcCosine

waitForResult:
	fcall pollCordic
	fcall isCordicIdle
	xorlw 0
	btfsc STATUS, Z
	goto waitForResult

testAssert:
	.aliasForAssert cordicResultLow, _a
	.aliasForAssert expectedCordicResultLow, _b
	.assert "_a == _b, 'Expected cordicResultLow == expectedCordicResultLow.'"

	.aliasForAssert cordicResultHigh, _a
	.aliasForAssert expectedCordicResultHigh, _b
	.assert "_a == _b, 'Expected cordicResultHigh == expectedCordicResultHigh.'"
	return

	end
