	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Timer0.inc"
	#include "Motor.inc"
	#include "../../Smps/IsSmpsEnabledStub.inc"
	#include "../../Adc/ChannelStubs.inc"
	#include "TestFixture.inc"

	radix decimal

	extern testAct

DUTY_CYCLE_INCREMENT equ 2
NUMBER_OF_SAMPLES equ 50

	udata
dutyCycleSamples res NUMBER_OF_SAMPLES

PwmDutyCycleFromRestTestFixture code
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

callTurnInTest:
	fcall testAct

synchroniseTestWithTimer1:
	call startTimer1
	banksel TMR1L

waitForFirstTick:
	btfss TMR1L, 0
	goto waitForFirstTick
	clrf TMR1L

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
		.aliasForAssert dutyCycleSamples + i, _a
		if (DUTY_CYCLE_INCREMENT * (i + 1) > 255)
			.aliasLiteralForAssert 255, _b
		else
			.aliasLiteralForAssert DUTY_CYCLE_INCREMENT * (i + 1), _b
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
