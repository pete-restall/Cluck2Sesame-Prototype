	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Flash.inc"
	#include "TestFixture.inc"

	radix decimal

flashAddressOf macro label
	banksel EEADRH
	movlw high(label)
	movwf EEADRH
	movlw low(label)
	movwf EEADR
	endm

ReadFlashWordAsPairOfSevenBitBytesWhenOddTest code
	global testArrange

testArrange:

testAct:
	flashAddressOf string
	fcall readFlashWordAsPairOfSevenBitBytes

testAssert:
	.aliasWForAssert _a
	.aliasLiteralForAssert 'Z', _b
	.assert "_a == _b, 'Expected high(string) == Z.'"

	.aliasForAssert EEDAT, _a
	.aliasLiteralForAssert '\0', _b
	.assert "_a == _b, 'Expected low(string) == null.'"
	return

string da "Z"

	end
