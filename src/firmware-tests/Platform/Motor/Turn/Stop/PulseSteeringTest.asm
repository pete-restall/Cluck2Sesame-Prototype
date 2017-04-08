	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Timer0.inc"
	#include "Motor.inc"
	#include "../../../Smps/IsSmpsEnabledStub.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global initialPstrcon

initialPstrcon res 1

PulseSteeringTest code
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

setDutyCycleAndPulseSteering:
	banksel CCPR1L
	movlw 0xff
	movwf CCPR1L

	banksel initialPstrcon
	movf initialPstrcon, W
	banksel PSTRCON
	movwf PSTRCON

	banksel PORTC
	bsf PORTC, RC4
	bsf PORTC, RC5

testAct:
	fcall stopMotor

testAssert:
	fcall pollMotor

	banksel CCPR1L
	movf CCPR1L
	btfsc STATUS, Z
	goto assertOutputsDisabled

	.aliasForAssert PSTRCON, _a
	.aliasForAssert initialPstrcon, _b
	.assert "_a == _b, 'Expected PSTRCON to remain unchanged while stopping.'"
	goto testAssert

assertOutputsDisabled:
	fcall pollMotor

	.aliasForAssert PSTRCON, _a
	.aliasLiteralForAssert (1 << STRSYNC), _b
	.assert "_a == _b, 'Expected pulse steering outputs to be disabled.'"

	banksel PORTC
	movlw (1 << RC4) | (1 << RC5)
	andwf PORTC, W
	.aliasWForAssert _a
	.assert "_a == 0, 'Expected PWM pins to be held low.'"

	return

	end
