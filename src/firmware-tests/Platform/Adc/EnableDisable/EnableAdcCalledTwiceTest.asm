	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Adc.inc"
	#include "TestFixture.inc"

	radix decimal

EnableAdcCalledTwiceTest code
	global testArrange

testArrange:
	fcall initialiseAdc

testAct:
	fcall enableAdc

waitUntilConversionHasCompleted:
	banksel ADCON0
	btfsc ADCON0, GO
	goto waitUntilConversionHasCompleted

callEnableForTheSecondTime:
	fcall enableAdc

testAssert:
	banksel ADCON0
	movf ADCON0, W
	andlw (1 << GO)
	.assert "W == 0, 'Second enableAdc() call should not have started a conversion.'"
	return

	end
