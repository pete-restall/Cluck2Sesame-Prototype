	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Adc.inc"
	#include "TestFixture.inc"

	radix decimal

VddAsVoltageReferenceTest code
	global testArrange

testArrange:
	banksel ADCON0
	bsf ADCON0, VCFG

testAct:
	fcall initialiseAdc

testAssert:
	banksel ADCON0
	movf ADCON0, W
	andlw (1 << VCFG)
	.assert "W == 0, 'Expected voltage reference is VDD.'"
	return

	end
