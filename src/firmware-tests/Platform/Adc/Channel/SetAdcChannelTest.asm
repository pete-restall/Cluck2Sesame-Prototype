	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Adc.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global adcChannel

adcChannel res 1
initialAdcon0 res 1

SetAdcChannelTest code
	global testArrange

testArrange:
	fcall initialiseAdc

	banksel ADCON0
	movf ADCON0, W
	banksel initialAdcon0
	movwf initialAdcon0

testAct:
	banksel adcChannel
	movf adcChannel, W
	fcall setAdcChannel

testAssert:
	.aliasWForAssert _a
	.assert "_a != 0, 'Expected return value (W) to be true.'"

	banksel adcChannel
	rlf adcChannel
	rlf adcChannel
	movlw b'00111100'
	andwf adcChannel
	banksel initialAdcon0
	movlw ~b'00111100'
	andwf initialAdcon0
	movf adcChannel, W
	iorwf initialAdcon0

	.aliasForAssert ADCON0, _a
	.aliasForAssert initialAdcon0, _b
	.assert "_a == _b, 'ADCON0 expectation mismatch.'"
	return

	end
