	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Adc.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global firstAdcChannel
	global secondAdcChannel

firstAdcChannel res 1
secondAdcChannel res 1
expectedAdcon0 res 1

SetAdcChannelAfterReleaseTest code
	global testArrange

testArrange:
	fcall initialiseAdc

testAct:
setAdcChannelForTheFirstTime:
	banksel firstAdcChannel
	movf firstAdcChannel, W
	fcall setAdcChannel

releaseFirstAdcChannel:
	fcall releaseAdcChannel

	banksel ADCON0
	movf ADCON0, W
	banksel expectedAdcon0
	andlw b'11000011'
	movwf expectedAdcon0

setAdcChannelForTheSecondTime:
	banksel secondAdcChannel
	movf secondAdcChannel, W
	fcall setAdcChannel

testAssert:
	.aliasWForAssert _a
	.assert "_a != 0, 'Expected return value (W) to be true.'"

	banksel secondAdcChannel
	rlf secondAdcChannel
	rlf secondAdcChannel
	movlw b'00111100'
	andwf secondAdcChannel, W
	iorwf expectedAdcon0

	.aliasForAssert ADCON0, _a
	.aliasForAssert expectedAdcon0, _b
	.assert "_a == _b, 'ADCON0 expectation mismatch.'"
	return

	end
