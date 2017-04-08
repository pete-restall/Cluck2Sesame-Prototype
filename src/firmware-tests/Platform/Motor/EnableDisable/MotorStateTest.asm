	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "TestFixture.inc"

	radix decimal

	extern motorState

	udata
	global numberOfEnableCalls
	global numberOfDisableCalls
	global expectedMotorState

numberOfEnableCalls res 1
numberOfDisableCalls res 1
expectedMotorState res 1

MotorStateTest code
	global testArrange

testArrange:
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
	.aliasForAssert motorState, _a
	.aliasForAssert expectedMotorState, _b
	.assert "_a == _b, 'Expected motorState == expectedMotorState.'"
	return

	end
