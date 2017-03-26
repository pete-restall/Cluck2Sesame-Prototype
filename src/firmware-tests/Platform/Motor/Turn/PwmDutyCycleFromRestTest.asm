	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Timer0.inc"
	#include "Motor.inc"
	#include "../../Smps/IsSmpsEnabledStub.inc"
	#include "TestFixture.inc"

	radix decimal

	extern testAct

NUMBER_OF_SOFT_START_SAMPLES equ 40
NUMBER_OF_SAMPLES equ NUMBER_OF_SOFT_START_SAMPLES + 10

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

callTurnFromFixture:
	fcall testAct

waitForFirstTick:
	xorwf TMR1L, W
	btfss STATUS, Z
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
	while (i < NUMBER_OF_SOFT_START_SAMPLES)
		.aliasForAssert dutyCycleSamples + i, _a
		.aliasLiteralForAssert 6 * (i + 1), _b
		.command "_a"
		.assert "_a == _b, 'Soft start duty cycle mismatch.'"
i += 1
	endw

	while (i < NUMBER_OF_SAMPLES)
		.aliasForAssert dutyCycleSamples + i, _a
		.assert "_a == 0xff, 'Expected duty cycle to be 100% after soft start.'"
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
