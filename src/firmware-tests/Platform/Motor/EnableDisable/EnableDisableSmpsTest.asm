	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "../../Smps/EnableDisableSmpsMocks.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global numberOfEnableCalls
	global numberOfDisableCalls
	global expectedCalledEnableSmpsCount
	global expectedCalledDisableSmpsCount

numberOfEnableCalls res 1
numberOfDisableCalls res 1
expectedCalledEnableSmpsCount res 1
expectedCalledDisableSmpsCount res 1

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
	.aliasForAssert calledEnableSmpsCount, _a
	.aliasForAssert expectedCalledEnableSmpsCount, _b
	.assert "_a == _b, 'Expected calls to enableSmps() did not match expectation.'"

	.aliasForAssert calledDisableSmpsCount, _a
	.aliasForAssert expectedCalledDisableSmpsCount, _b
	.assert "_a == _b, 'Expected calls to disableSmps() did not match expectation.'"
	return

	end
