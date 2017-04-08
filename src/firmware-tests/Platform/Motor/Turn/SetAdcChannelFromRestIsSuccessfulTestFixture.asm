	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "../../Smps/IsSmpsEnabledStub.inc"
	#include "../../Adc/ChannelStubs.inc"
	#include "TestFixture.inc"

	radix decimal

	extern testAct

SetAdcChannelFromRestIsSuccessfulTestFixture code
	global testArrange

testArrange:
	movlw 1
	fcall initialiseIsSmpsEnabledStub

	movlw 1
	fcall initialiseSetAdcChannelStub

	fcall initialiseMotor
	fcall enableMotorVdd

waitUntilMotorVddIsEnabled:
	fcall pollMotor
	fcall isMotorVddEnabled
	xorlw 0
	btfsc STATUS, Z
	goto waitUntilMotorVddIsEnabled

callTurnInTest:
	fcall testAct

testAssert:
	.aliasWForAssert _a
	.assert "_a != 0, 'Expected return value (W) to be successful (true).'"

	banksel PSTRCON
	movlw ~(1 << STRSYNC)
	andwf PSTRCON, W
	.aliasWForAssert _a
	.assert "_a != 0, 'Expected PWM pulse steering to be enabled.'"
	return

	end
