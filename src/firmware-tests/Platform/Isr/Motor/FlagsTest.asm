	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Isr.inc"
	#include "Adc.inc"
	#include "Motor.inc"
	#include "TestFixture.inc"

	radix decimal

	extern isr

MOTOR_ADC_CHANNEL equ b'00011100'

	udata
	global adcResult
	global initialPstrcon
	global initialMotorFlags
	global expectedPstrcon
	global expectedMotorFlags

adcResult res 1
initialMotorFlags res 1
initialPstrcon res 1
initialPortc res 1
expectedMotorFlags res 1
expectedPstrcon res 1
expectedPortc res 1

FlagsTest code
	global testArrange

testArrange:
	fcall initialiseIsr
	fcall initialiseAdc

setInitialMotorFlags:
	banksel initialMotorFlags
	movf initialMotorFlags, W
	banksel motorFlags
	movwf motorFlags

setAdcResult:
	banksel ADCON0
	movlw MOTOR_ADC_CHANNEL
	movwf ADCON0
	bsf ADCON0, ADON

	banksel adcResult
	movf adcResult, W
	banksel ADRESH
	clrf ADRESL
	movwf ADRESH

	banksel PIR1
	bsf PIR1, ADIF

setInitialPulseSteering:
	banksel initialPstrcon
	movf initialPstrcon, W
	banksel PSTRCON
	movwf PSTRCON

setInitialPortValueToRandomPattern:
	banksel ANSEL
	clrf ANSEL
	banksel ANSELH
	clrf ANSELH
	banksel TRISC
	clrf TRISC

	banksel initialPortc
	movf initialPortc, W
	banksel PORTC
	movwf PORTC

setPortExpectationBasedOnWhetherPulseSteeringIsEnabledOnIsrEntry:
	banksel initialPstrcon
	movlw (1 << STRA) | (1 << STRB)
	andwf initialPstrcon, W
	btfss STATUS, Z
	goto setPortExpectationBasedOnPulseSteeringExpectation

motorNotEnabledOnIsrEntrySoPortExpectationIsSameAsInitialPort:
	banksel PORTC
	movf PORTC, W
	banksel expectedPortc
	movwf expectedPortc
	goto testAct

setPortExpectationBasedOnPulseSteeringExpectation:
	banksel PORTC
	movf PORTC, W

	banksel expectedPstrcon
	btfss expectedPstrcon, STRA
	andlw ~(1 << RC5)
	btfss expectedPstrcon, STRB
	andlw ~(1 << RC4)

	banksel expectedPortc
	movwf expectedPortc

testAct:
	fcall isr

testAssert:
	.aliasForAssert motorFlags, _a
	.aliasForAssert expectedMotorFlags, _b
	.assert "_a == _b, 'Expected motorFlags == expectedMotorFlags.'"

	.aliasForAssert PSTRCON, _a
	.aliasForAssert expectedPstrcon, _b
	.assert "_a == _b, 'Expected PSTRCON == expectedPstrcon.'"

	.aliasForAssert PORTC, _a
	.aliasForAssert expectedPortc, _b
	.assert "_a == _b, 'Expected PORTC == expectedPortc.'"
	return

	end
