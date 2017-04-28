	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Timer0.inc"
	#include "Motor.inc"
	#include "../../../Smps/IsSmpsEnabledStub.inc"
	#include "TestFixture.inc"

	radix decimal

PulseSteeringForReverseTest code
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

	fcall turnMotorAntiClockwise

waitUntilMotorIsFullyTurning:
	fcall pollMotor

	banksel CCPR1L
	movlw 0xff
	xorwf CCPR1L, W
	btfss STATUS, Z
	goto waitUntilMotorIsFullyTurning

testAct:
	fcall turnMotorClockwise

assertSoftStop:
	fcall pollMotor

	banksel CCPR1L
	movf CCPR1L
	btfsc STATUS, Z
	goto forceP1BHighToForceRmwGlitchBehaviour

	.aliasForAssert PSTRCON, _a
	.aliasLiteralForAssert (1 << STRB) | (1 << STRSYNC), _b
	.assert "_a == _b, 'Expected pulse steering into P1B (only) for soft stop.'"

	banksel PORTC
	movlw (1 << RC5)
	andwf PORTC, W
	.aliasWForAssert _a
	.assert "_a == 0, 'Expected unused PWM pin to be held low.'"
	goto assertSoftStop

forceP1BHighToForceRmwGlitchBehaviour:
	call forceP1BHigh

assertSoftStart:
	fcall pollMotor

	.aliasForAssert PSTRCON, _a
	.aliasLiteralForAssert (1 << STRA) | (1 << STRSYNC), _b
	.assert "_a == _b, 'Expected pulse steering into P1A (only) for soft start.'"

	banksel PORTC
	movlw (1 << RC4)
	andwf PORTC, W
	.aliasWForAssert _a
	.assert "_a == 0, 'Expected unused PWM pin to be held low.'"

	banksel CCPR1L
	comf CCPR1L, W
	btfss STATUS, Z
	goto assertSoftStart

	return

forceP1BHigh:
	banksel PSTRCON
	bcf PSTRCON, STRB

	banksel PIR1
	bcf PIR1, TMR2IF

waitForNextTimer2Period:
	btfss PIR1, TMR2IF
	goto waitForNextTimer2Period

	banksel PORTC
	bsf PORTC, RC4
	return

	end
