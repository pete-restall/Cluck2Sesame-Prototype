	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Adc.inc"
	#include "TestFixture.inc"

	radix decimal

ChannelIsComparatorReferenceTest code
	global testArrange

testArrange:
	banksel ADCON0
	clrf ADCON0

testAct:
	fcall initialiseAdc

testAssert:
	banksel VRCON
	movlw 1 << VP6EN
	andwf VRCON, W
	.assert "W == 0, 'Expected comparator reference to be 0V.'"
	
	banksel ADCON0
	movf ADCON0, W
	andlw b'00111100'
	.assert "W == b'00110000', 'Expected channel is internal (0V) comparator reference.'"
	return

	end
