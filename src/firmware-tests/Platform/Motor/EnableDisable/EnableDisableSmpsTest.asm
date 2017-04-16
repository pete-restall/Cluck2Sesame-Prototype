	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "../../Smps/EnableDisableSmpsMocks.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global numberOfEnableCalls
	global numberOfDisableCalls
	global expectedCalledEnableSmpsHighPowerModeCount
	global expectedCalledDisableSmpsHighPowerModeCount

numberOfEnableCalls res 1
numberOfDisableCalls res 1
expectedCalledEnableSmpsHighPowerModeCount res 1
expectedCalledDisableSmpsHighPowerModeCount res 1

EnableDisableSmpsTest code
	global testArrange

testArrange:
	fcall initialiseEnableAndDisableSmpsMocks
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
	.aliasForAssert calledEnableSmpsHighPowerModeCount, _a
	.aliasForAssert expectedCalledEnableSmpsHighPowerModeCount, _b
	.assert "_a == _b, 'Expected calls to enableSmpsHighPowerMode() did not match expectation.'"

	.aliasForAssert calledDisableSmpsHighPowerModeCount, _a
	.aliasForAssert expectedCalledDisableSmpsHighPowerModeCount, _b
	.assert "_a == _b, 'Expected calls to disableSmpsHighPowerMode() did not match expectation.'"
	return

	end
