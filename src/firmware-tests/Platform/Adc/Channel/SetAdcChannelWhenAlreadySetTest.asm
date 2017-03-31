	#include "Mcu.inc"
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

SetAdcChannelWhenAlreadySetTest code
	global testArrange

testArrange:
	fcall initialiseAdc

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
	.assert "_a == 0, 'Expected return value (W) to be false.'"

	.aliasForAssert ADCON0, _a
	.aliasForAssert expectedAdcon0, _b
	.assert "_a == _b, 'Expected ADCON0 to be unmodified on the second attempt.'"
	return

	end
