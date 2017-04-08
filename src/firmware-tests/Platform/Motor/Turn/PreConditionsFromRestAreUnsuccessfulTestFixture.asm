	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "../../Smps/IsSmpsEnabledStub.inc"
	#include "../../Adc/ChannelStubs.inc"
	#include "TestFixture.inc"

	radix decimal

	extern testAct
	extern motorState

	udata
	global setAdcChannelResult
	global initialMotorState

setAdcChannelResult res 1
initialMotorState res 1
initialPstrcon res 1

PreConditionsFromRestAreUnsuccessfulTestFixture code
	global testArrange

testArrange:
	movlw 1
	fcall initialiseIsSmpsEnabledStub

	banksel setAdcChannelResult
	movf setAdcChannelResult, W
	fcall initialiseSetAdcChannelStub

	fcall initialiseMotor
	fcall enableMotorVdd

waitUntilMotorVddIsEnabled:
	fcall pollMotor
	fcall isMotorVddEnabled
	xorlw 0
	btfsc STATUS, Z
	goto waitUntilMotorVddIsEnabled

setInitialMotorState:
	banksel initialMotorState
	movf initialMotorState, W
	banksel motorState
	movwf motorState

setInitialPstrcon:
	banksel initialPstrcon
	movlw 0x1f
	andwf initialPstrcon
	movf initialPstrcon, W
	banksel PSTRCON
	movwf PSTRCON

callTurnInTest:
	fcall testAct

testAssert:
	.aliasWForAssert _a
	.assert "_a == 0, 'Expected return value (W) to be unsuccessful (false).'"

	.aliasForAssert PSTRCON, _a
	.aliasForAssert initialPstrcon, _b
	.assert "_a == _b, 'Expected PWM pulse steering to be unmodified.'"

	.aliasForAssert motorState, _a
	.aliasForAssert initialMotorState, _b
	.assert "_a == _b, 'Expected motor state to be unmodified.'"
	return

	end
