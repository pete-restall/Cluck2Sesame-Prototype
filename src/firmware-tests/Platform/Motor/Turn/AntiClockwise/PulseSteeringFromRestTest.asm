	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Timer0.inc"
	#include "Motor.inc"
	#include "../../../Smps/IsSmpsEnabledStub.inc"
	#include "TestFixture.inc"

	radix decimal

PulseSteeringFromRestTest code
	global testArrange

testArrange:
	movlw 1
	fcall initialiseIsSmpsEnabledStub

	fcall initialiseTimer0
	fcall initialiseMotor
	fcall enableMotorVdd

waitUntilMotorVddIsEnabled:
	fcall pollMotor
	fcall isMotorVddEnabled
	xorlw 0
	btfsc STATUS, Z
	goto waitUntilMotorVddIsEnabled

testAct:
	fcall turnMotorAntiClockwise

testAssert:
	.aliasForAssert PSTRCON, _a
	.aliasLiteralForAssert (1 << STRB) | (1 << STRSYNC), _b
	.assert "_a == _b, 'Expected pulse steering into P1B (only).'"
	return

	end
