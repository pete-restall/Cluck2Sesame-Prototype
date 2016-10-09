	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "MclrReset.inc"
	#include "TestFixture.inc"
	radix decimal

UlpwuDisabledTest code
	global testArrange

testArrange:
	banksel PCON
	movlw 0xff 
	movwf PCON

testAct:
	fcall initialiseAfterMclrReset

testAssert:
	.assert "(pcon & 0x20) == 0, 'ULPWUE bit should not be set.'"

	.done

	end
