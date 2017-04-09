	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "../../MotorStates.inc"
	#include "../../../Smps/IsSmpsEnabledStub.inc"
	#include "../../../Adc/ChannelMocks.inc"
	#include "TestFixture.inc"

	radix decimal

	extern motorState

ReleaseAdcChannelTest code
	global testArrange

testArrange:
	movlw 1
	fcall initialiseIsSmpsEnabledStub

	movlw 1
	fcall initialiseSetAdcChannelMock
	fcall initialiseReleaseAdcChannelMock

	fcall initialiseMotor
	fcall enableMotorVdd

waitUntilMotorVddIsEnabled:
	fcall pollMotor
	fcall isMotorVddEnabled
	xorlw 0
	btfsc STATUS, Z
	goto waitUntilMotorVddIsEnabled

turnMotor:
	fcall turnMotorClockwise
	fcall pollMotor

testAct:
	fcall stopMotor

waitUntilMotorIsStopped:
	fcall pollMotor
	banksel motorState
	movf motorState, W
	xorlw MOTOR_STATE_STOPPED
	btfss STATUS, Z
	goto waitUntilMotorIsStopped

testAssert:
	.aliasForAssert calledReleaseAdcChannel, _a
	.assert "_a == 0, 'Expected releaseAdcChannel() has not been called before the motor has been stopped.'"

	fcall pollMotor

	.aliasForAssert calledReleaseAdcChannel, _a
	.assert "_a != 0, 'Expected releaseAdcChannel() to be called after the motor has been stopped.'"

	return

	end
