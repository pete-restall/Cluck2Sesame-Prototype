	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Cordic.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global sinPhiHigh
	global sinPhiLow
	global expectedCordicResultHigh
	global expectedCordicResultLow

sinPhi:
sinPhiHigh res 1
sinPhiLow res 1

expectedCordicResultHigh res 1
expectedCordicResultLow res 1

ArcSineTest code
	global testArrange

testArrange:
	fcall initialiseCordic

testAct:
	loadArcSineArgument sinPhi
	fcall arcSine

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
