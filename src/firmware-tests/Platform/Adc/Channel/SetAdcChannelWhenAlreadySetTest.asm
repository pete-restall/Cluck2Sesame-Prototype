	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Adc.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global initialAdcChannel
	global attemptedAdcChannel

initialAdcChannel res 1
attemptedAdcChannel res 1
expectedAdcon0 res 1
expectedW res 1

SetAdcChannelWhenAlreadySetTest code
	global testArrange

testArrange:
	fcall initialiseAdc

	banksel initialAdcChannel
	movf initialAdcChannel, W
	xorwf attemptedAdcChannel, W
	btfsc STATUS, Z
	goto setExpectedWForSameChannels

setExpectedWForDifferentChannels:
	movlw SET_ADC_CHANNEL_FAILURE
	movwf expectedW
	goto setAdcChannelForTheFirstTime

setExpectedWForSameChannels:
	movlw SET_ADC_CHANNEL_SAME
	movwf expectedW

setAdcChannelForTheFirstTime:
	banksel initialAdcChannel
	movf initialAdcChannel, W
	fcall setAdcChannel

	banksel ADCON0
	movf ADCON0, W
	banksel expectedAdcon0
	movwf expectedAdcon0

testAct:
	banksel attemptedAdcChannel
	movf attemptedAdcChannel, W
	fcall setAdcChannel

testAssert:
	.aliasWForAssert _a
	.aliasForAssert expectedW, _b
	.assert "_a == _b, 'Expected return value (W) to be SET_ADC_CHANNEL_FAILURE or SET_ADC_CHANNEL_SAME.'"

	.aliasForAssert ADCON0, _a
	.aliasForAssert expectedAdcon0, _b
	.assert "_a == _b, 'Expected ADCON0 to be unmodified on the second attempt.'"
	return

	end
