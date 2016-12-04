	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Adc.inc"
	#include "TestFixture.inc"

	radix decimal

ChannelIsInternalReferenceTest code
	global testArrange

testArrange:
	banksel ADCON0
	clrf ADCON0

testAct:
	fcall initialiseAdc

testAssert:
	banksel ADCON0
	movf ADCON0, W
	andlw b'00111100'
	.assert "W == b'00110100', 'Expected channel is internal 0.6V reference.'"
	return

	end
