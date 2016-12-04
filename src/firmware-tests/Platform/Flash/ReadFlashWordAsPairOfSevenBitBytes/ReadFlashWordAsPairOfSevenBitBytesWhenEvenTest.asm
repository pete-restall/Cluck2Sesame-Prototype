	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Flash.inc"
	#include "TestFixture.inc"

	radix decimal

ReadFlashWordAsPairOfSevenBitBytesWhenEvenTest code
	global testArrange

testArrange:

testAct:
	loadFlashAddressOf string
	fcall readFlashWordAsPairOfSevenBitBytes

testAssert:
	.aliasWForAssert _a
	.aliasLiteralForAssert 'A', _b
	.assert "_a == _b, 'Expected high(string) == A.'"

	.aliasForAssert EEDAT, _a
	.aliasLiteralForAssert 'B', _b
	.assert "_a == _b, 'Expected low(string) == B.'"
	return

string da "AB"

	end
