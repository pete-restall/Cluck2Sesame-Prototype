	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Timer0.inc"
	#include "Motor.inc"
	#include "../../Smps/IsSmpsEnabledStub.inc"
	#include "TestFixture.inc"

	radix decimal

NUMBER_OF_SAMPLES equ 10

	udata
dutyCycleSamples res NUMBER_OF_SAMPLES

PwmDutyCycleFromRestTest code
	global testArrange

testArrange:
	call initialiseTimer1

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

synchroniseTestWithTimer1:
	call startTimer1
	banksel TMR1L
	movlw 1

waitForFirstTick:
	xorwf TMR1L, W
	btfss STATUS, Z
	goto waitForFirstTick
	clrf TMR1L

testAct:
	fcall turnMotorClockwise

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
	.aliasForAssert dutyCycleSamples + 0, _a
	.aliasLiteralForAssert 25, _b
	.assert "_a == (1 * _b), 'Expected first duty cycle to be 10%.'"

	.aliasForAssert dutyCycleSamples + 1, _a
	.assert "_a == (2 * _b), 'Expected second duty cycle to be 20%.'"

	.aliasForAssert dutyCycleSamples + 2, _a
	.assert "_a == (3 * _b), 'Expected third duty cycle to be 30%.'"

	.aliasForAssert dutyCycleSamples + 3, _a
	.assert "_a == (4 * _b), 'Expected fourth duty cycle to be 40%.'"

	.aliasForAssert dutyCycleSamples + 4, _a
	.assert "_a == (5 * _b), 'Expected fifth duty cycle to be 50%.'"

	variable i = 5
	while (i < NUMBER_OF_SAMPLES)
		.aliasForAssert dutyCycleSamples + i, _a
		.assert "_a == 0xff, 'Expected sixth and above duty cycle to be 100%.'"
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
