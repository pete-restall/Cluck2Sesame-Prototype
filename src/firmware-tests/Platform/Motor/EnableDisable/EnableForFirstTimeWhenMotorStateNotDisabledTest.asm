	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "../../../../firmware/Platform/Motor/States.inc"
	#include "../../Smps/IsSmpsEnabledStub.inc"
	#include "TestFixture.inc"

	radix decimal

	extern motorState

	udata
randomByte res 1

EnableForFirstTimeWhenMotorStateNotDisabledTest code
	global testArrange

testArrange:
	movlw 1
	fcall initialiseIsSmpsEnabledStub

	fcall initialiseMotor

ensureMotorStateIsNotDisabled:
	banksel randomByte
	movf randomByte, W
	xorlw MOTOR_STATE_DISABLED
	btfsc STATUS, Z
	movlw 0xff
	xorlw MOTOR_STATE_DISABLED

	banksel motorState
	movwf motorState

testAct:
	fcall enableMotorVdd

testAssert:
	.aliasForAssert motorState, _a
	.aliasLiteralForAssert MOTOR_STATE_IDLE, _b
	.assert "_a == _b, 'Expected motorState == MOTOR_STATE_IDLE.'"
	return

	end
