	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Adc.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global numberOfEnableCalls
	global numberOfDisableCalls
	global initialAdcon0
	global expectedAdcon0

numberOfEnableCalls res 1
numberOfDisableCalls res 1
initialAdcon0 res 1
expectedAdcon0 res 1

EnableDisableAdcTest code
	global testArrange

testArrange:
	fcall initialiseAdc

setAdcClockSourceToSlowestToAvoidHardwareClearingGoBitDuringTest:
	banksel ADCON1
	movlw b'01100000'
	movwf ADCON1

setInitialAdcon0:
	banksel initialAdcon0
	movf initialAdcon0, W
	banksel ADCON0
	movwf ADCON0

testAct:
	banksel numberOfEnableCalls
	movf numberOfEnableCalls
	btfsc STATUS, Z
	goto callDisableAdc

callEnableAdc:
	fcall enableAdc
	banksel numberOfEnableCalls
	decfsz numberOfEnableCalls
	goto testAct

callDisableAdc:
	banksel numberOfDisableCalls
	movf numberOfDisableCalls
	btfsc STATUS, Z
	goto testAssert

callDisableAdcInLoop:
	fcall disableAdc
	banksel numberOfDisableCalls
	decfsz numberOfDisableCalls
	goto callDisableAdcInLoop

testAssert:
	.aliasForAssert ADCON0, _a
	.aliasForAssert expectedAdcon0, _b
	.assert "_a == _b, 'ADCON0 expectation failure.'"
	return

	end
