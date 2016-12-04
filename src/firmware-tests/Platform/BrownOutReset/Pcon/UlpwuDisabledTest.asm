	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "BrownOutReset.inc"
	#include "TestFixture.inc"

	radix decimal

UlpwuDisabledTest code
	global testArrange

testArrange:
	banksel PCON
	movlw 0xff 
	movwf PCON

testAct:
	fcall initialiseAfterBrownOutReset

testAssert:
	banksel PCON
	.assert "(pcon & 0x20) == 0, 'ULPWUE bit should not be set.'"
	return

	end
