	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "../../Adc/EnableDisableAdcMocks.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global numberOfEnableCalls
	global numberOfDisableCalls
	global expectedCalledEnableAdcCount
	global expectedCalledDisableAdcCount

numberOfEnableCalls res 1
numberOfDisableCalls res 1
expectedCalledEnableAdcCount res 1
expectedCalledDisableAdcCount res 1

EnableDisableAdcTest code
	global testArrange

testArrange:
	fcall initialiseEnableAndDisableAdcMocks
	fcall initialiseMotor

testAct:
	banksel numberOfEnableCalls
	movf numberOfEnableCalls
	btfsc STATUS, Z
	goto callDisableMotorVdd

callEnableMotorVdd:
	fcall enableMotorVdd
	banksel numberOfEnableCalls
	decfsz numberOfEnableCalls
	goto testAct

callDisableMotorVdd:
	banksel numberOfDisableCalls
	movf numberOfDisableCalls
	btfsc STATUS, Z
	goto testAssert

callDisableMotorVddInLoop:
	fcall disableMotorVdd
	banksel numberOfDisableCalls
	decfsz numberOfDisableCalls
	goto callDisableMotorVddInLoop

testAssert:
	.aliasForAssert calledEnableAdcCount, _a
	.aliasForAssert expectedCalledEnableAdcCount, _b
	.assert "_a == _b, 'Expected calls to enableAdc() did not match expectation.'"

	.aliasForAssert calledDisableAdcCount, _a
	.aliasForAssert expectedCalledDisableAdcCount, _b
	.assert "_a == _b, 'Expected calls to disableAdc() did not match expectation.'"
	return

	end
