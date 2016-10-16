	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "BrownOutReset.inc"
	#include "TestFixture.inc"

	radix decimal

BorDisabledTest code
	global testArrange

testArrange:
	banksel PCON
	movlw 0xff
	movwf PCON

testAct:
	fcall initialiseAfterBrownOutReset

testAssert:
	.assert "(pcon & 0x10) == 0, 'SBOREN bit should not be set.'"
	return

	end
