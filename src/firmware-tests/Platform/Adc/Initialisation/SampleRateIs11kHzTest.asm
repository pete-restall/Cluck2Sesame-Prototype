	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Adc.inc"
	#include "TestFixture.inc"

	radix decimal

SampleRateIs11kHzTest code
	global testArrange

testArrange:
	banksel ADCON1
	clrf ADCON1

testAct:
	fcall initialiseAdc

testAssert:
	banksel ADCON1
	movf ADCON1, W
	andlw b'01110000'
	.assert "W == b'00100000', 'Expected 4MHz clock is divided by 32 for an 8us conversion clock.'"
	return

	end
