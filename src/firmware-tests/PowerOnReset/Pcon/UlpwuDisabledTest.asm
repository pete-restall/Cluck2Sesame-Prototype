	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "TestFixture.inc"
	radix decimal

	extern initialiseAfterPowerOnReset

UlpwuDisabledTest code
	global testArrange

testArrange:
	banksel PCON
	movlw -1
	movwf PCON

testAct:
	fcall initialiseAfterPowerOnReset

testAssert:
	.assert "(pcon & 0x20) == 0, \"ULPWUE bit should not be set.\""

	.done

	end
