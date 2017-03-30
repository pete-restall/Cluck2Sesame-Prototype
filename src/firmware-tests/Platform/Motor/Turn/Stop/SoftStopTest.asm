	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Timer0.inc"
	#include "Motor.inc"
	#include "../../../Smps/IsSmpsEnabledStub.inc"
	#include "TestFixture.inc"

	radix decimal

DUTY_CYCLE_DECREMENT equ 6
NUMBER_OF_SAMPLES equ 45

	udata
	global initialDutyCycle

initialDutyCycle res 1

StopSampleBuffer udata
dutyCycleSamples res NUMBER_OF_SAMPLES

SoftStopTest code
	global testArrange

testArrange:
	call initialiseTimer1

	movlw 1
	fcall initialiseIsSmpsEnabledStub

	fcall initialiseTimer0

preventWeirdGpsimBugOfNonIncrementingTmr0:
	banksel TMR0
	movf TMR0

resumeInitialisation:
	fcall initialiseMotor
	fcall enableMotorVdd

waitUntilMotorVddIsEnabled:
	fcall pollMotor
	fcall isMotorVddEnabled
	xorlw 0
	btfsc STATUS, Z
	goto waitUntilMotorVddIsEnabled

setDutyCycleAndPulseSteering:
	banksel initialDutyCycle
	movf initialDutyCycle, W
	banksel CCPR1L
	movwf CCPR1L

	banksel PSTRCON
	movlw 0xff
	movwf PSTRCON

synchroniseTestWithTimer1:
	call startTimer1
	banksel TMR1L

waitForFirstTick:
	btfss TMR1L, 0
	goto waitForFirstTick
	clrf TMR1L

testAct:
	fcall stopMotor

sampleUntilNoMoreBufferSpace:
	fcall pollMotor

	banksel TMR1L
	movf TMR1L, W
	movwf FSR
	sublw NUMBER_OF_SAMPLES - 1
	btfss STATUS, C
	goto testAssert

	bankisel dutyCycleSamples
	movlw dutyCycleSamples
	addwf FSR

	banksel CCPR1L
	movf CCPR1L, W
	movwf INDF

	goto sampleUntilNoMoreBufferSpace

testAssert:
	variable i = 0
	.command "echo Samples:"
	while (i < NUMBER_OF_SAMPLES)
assertDutyCycleIsDecrementedButNotPastZero_#v(i):
		banksel initialDutyCycle
		movlw DUTY_CYCLE_DECREMENT
		subwf initialDutyCycle, W
		btfss STATUS, C
		clrw
		movwf initialDutyCycle

		.aliasForAssert dutyCycleSamples + i, _a
		.aliasForAssert initialDutyCycle, _b
		.command "_a"
		.assert "_a == _b, 'Soft stop duty cycle mismatch.'"
i += 1
	endw

	return

initialiseTimer1:
	banksel T1CON
	movlw (1 << TMR1CS) | (1 << T1OSCEN)
	movwf T1CON

	banksel TMR1H
	clrf TMR1H
	clrf TMR1L
	return

startTimer1:
	banksel T1CON
	bsf T1CON, TMR1ON
	return

	end
