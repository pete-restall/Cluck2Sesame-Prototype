	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "../../Smps/IsSmpsEnabledStub.inc"
	#include "../../Adc/ChannelStubs.inc"
	#include "TestFixture.inc"

	radix decimal

	extern testAct

SetAdcChannelFromRestIsUnsuccessfulTestFixture code
	global testArrange

testArrange:
	movlw 1
	fcall initialiseIsSmpsEnabledStub

	movlw 0
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
	.assert "_a == 0, 'Expected return value (W) to be unsuccessful (false).'"

	.aliasForAssert PSTRCON, _a
	.aliasLiteralForAssert 1 << STRSYNC, _b
	.assert "_a == _b, 'Expected PWM pulse steering to be disabled.'"
	return

	end
