	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "../MotorStates.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global initialPstrcon
	global expectedMotorState

initialPstrcon res 1
expectedMotorState res 1

TurningThenStoppedTest code
	global testArrange

testArrange:
	fcall initialiseMotor

	banksel motorState
	movlw MOTOR_STATE_TURNING
	movwf motorState

	banksel initialPstrcon
	movf initialPstrcon, W
	banksel PSTRCON
	movwf PSTRCON

testAct:
	fcall pollMotor

testAssert:
	.aliasForAssert motorState, _a
	.aliasForAssert expectedMotorState, _b
	.assert "_a == _b, 'Expected motorState == expectedMotorState.'"
	return

	end
