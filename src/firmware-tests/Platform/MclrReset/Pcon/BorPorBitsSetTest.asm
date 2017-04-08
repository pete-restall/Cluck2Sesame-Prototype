	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "MclrReset.inc"
	#include "TestFixture.inc"

	radix decimal

BorPorBitsSetTest code
	global testArrange

testArrange:
	banksel PCON
	clrf PCON

testAct:
	fcall initialiseAfterMclrReset

testAssert:
	banksel PCON
	.assert "(pcon & 0x03) == 0x03, 'BOR / POR bits were not set.'"
	return

	end
