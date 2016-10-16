	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "PowerOnReset.inc"
	#include "TestFixture.inc"

	radix decimal

BorPorBitsSetTest code
	global testArrange

testArrange:
	banksel PCON
	clrf PCON

testAct:
	fcall initialiseAfterPowerOnReset

testAssert:
	.assert "(pcon & 0x03) == 0x03, 'BOR / POR bits were not set.'"
	return

	end
