	#include "Mcu.inc"
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
	global initialMotorFlags
	global expectedMotorFlags

adcResult res 1
initialMotorFlags res 1
expectedMotorFlags res 1

FlagsTest code
	global testArrange

testArrange:
	fcall initialiseAdc

	banksel initialMotorFlags
	movf initialMotorFlags, W
	banksel motorFlags
	movwf motorFlags

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

testAct:
	fcall isr

testAssert:
	.aliasForAssert motorFlags, _a
	.aliasForAssert expectedMotorFlags, _b
	.assert "_a == _b, 'Expected motorFlags == expectedMotorFlags.'"
	return

	end
