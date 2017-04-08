	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Timer0.inc"
	#include "Motor.inc"
	#include "../../Smps/IsSmpsEnabledStub.inc"
	#include "../../Adc/ChannelStubs.inc"
	#include "TestFixture.inc"

	radix decimal

	extern testArrangeStartTurning
	extern testActReverse

NUMBER_OF_STOP_SAMPLES equ 43
NUMBER_OF_START_SAMPLES equ 43

StopSampleBuffer udata
dutyCycleStopSamples res NUMBER_OF_STOP_SAMPLES

StartSampleBuffer udata
dutyCycleStartSamples res NUMBER_OF_START_SAMPLES

PwmDutyCycleForReverseTestFixture code
	global testArrange

testArrange:
	call initialiseTimer1

	movlw 1
	fcall initialiseIsSmpsEnabledStub

	movlw 1
	fcall initialiseSetAdcChannelStub

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

callTestToTurnAtFullSpeed:
	fcall testArrangeStartTurning
	.assert "W != 0, 'Unable to turn motor in the initial direction.'"

waitUntilTurningAtFullSpeed:
	fcall pollMotor
	banksel CCPR1L
	comf CCPR1L, W
	btfss STATUS, Z
	goto waitUntilTurningAtFullSpeed

testAct:
	fcall testActReverse

synchroniseTestWithTimer1:
	call startTimer1
	banksel TMR1L

waitForFirstTick:
	btfss TMR1L, 0
	goto waitForFirstTick
	clrf TMR1L

sampleStopsUntilNoMoreBufferSpace:
	fcall pollMotor

	banksel TMR1L
	movf TMR1L, W
	movwf FSR
	sublw NUMBER_OF_STOP_SAMPLES - 1
	btfss STATUS, C
	goto nextSampleBuffer

	bankisel dutyCycleStopSamples
	movlw dutyCycleStopSamples
	addwf FSR

	banksel CCPR1L
	movf CCPR1L, W
	movwf INDF

	goto sampleStopsUntilNoMoreBufferSpace

nextSampleBuffer:
	banksel TMR1L
	clrf TMR1L

sampleStartsUntilNoMoreBufferSpace:
	fcall pollMotor

	banksel TMR1L
	movf TMR1L, W
	movwf FSR
	sublw NUMBER_OF_START_SAMPLES - 1
	btfss STATUS, C
	goto testAssert

	bankisel dutyCycleStartSamples
	movlw dutyCycleStartSamples
	addwf FSR

	banksel CCPR1L
	movf CCPR1L, W
	movwf INDF

	goto sampleStartsUntilNoMoreBufferSpace

testAssert:
	variable i = 0
	.command "echo Stop Samples:"
	while (i < NUMBER_OF_STOP_SAMPLES)
		.aliasForAssert dutyCycleStopSamples + i, _a
		if (255 - 6 * (i + 1) >= 0)
			.aliasLiteralForAssert 255 - 6 * (i + 1), _b
		else
			.aliasLiteralForAssert 0, _b
		endif
		.command "_a"
		.assert "_a == _b, 'Soft stop duty cycle mismatch.'"
i += 1
	endw

i = 0
	.command "echo Start Samples:"
	while (i < NUMBER_OF_START_SAMPLES)
		.aliasForAssert dutyCycleStartSamples + i, _a
		if (6 * (i + 1) > 255)
			.aliasLiteralForAssert 255, _b
		else
			.aliasLiteralForAssert 6 * (i + 1), _b
		endif
		.command "_a"
		.assert "_a == _b, 'Soft start duty cycle mismatch.'"
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
