	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "TestFixture.inc"

	radix decimal

	extern motorState

	udata
expectedMotorState res 1

EnableForSecondTimeWhenMotorStateNotIdleTest code
	global testArrange

testArrange:
	fcall initialiseMotor
	fcall enableMotorVdd

	banksel expectedMotorState
	movf expectedMotorState, W
	banksel motorState
	movwf motorState

testAct:
	fcall enableMotorVdd

testAssert:
	.aliasForAssert motorState, _a
	.aliasForAssert expectedMotorState, _b
	.assert "_a == _b, 'Expected motorState == expectedMotorState.'"
	return

	end
