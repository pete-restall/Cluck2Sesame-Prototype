	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Adc.inc"
	#include "TestFixture.inc"

	radix decimal

LeftJustifiedTest code
	global testArrange

testArrange:
	banksel ADCON0
	bsf ADCON0, ADFM

testAct:
	fcall initialiseAdc

testAssert:
	banksel ADCON0
	movf ADCON0, W
	andlw (1 << ADFM)
	.assert "W == 0, 'Expected results are left-justified.'"
	return

	end
