	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Cordic.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global phiHigh
	global phiLow
	global expectedCordicResultHigh
	global expectedCordicResultLow

phi:
phiHigh res 1
phiLow res 1

expectedCordicResultHigh res 1
expectedCordicResultLow res 1

SineTest code
	global testArrange

testArrange:
	fcall initialiseCordic

testAct:
	loadSineArgument phi
	fcall sine

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
