	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Adc.inc"
	#include "TestFixture.inc"

	radix decimal

AdcDisabledTest code
	global testArrange

testArrange:
setAdcClockSourceToSlowestToAvoidHardwareClearingGoBitDuringTest:
	banksel ADCON1
	movlw b'01100000'
	movwf ADCON1

	banksel ADCON0
	movlw 0xff
	movwf ADCON0

testAct:
	fcall initialiseAdc

testAssert:
	banksel ADCON0
	movf ADCON0, W
	andlw (1 << ADON) | (1 << GO)
	.assert "W == 0, 'Expected ADC to be disabled.'"
	return

	end
