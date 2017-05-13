	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Isr.inc"
	#include "Adc.inc"
	#include "Motor.inc"
	#include "TestFixture.inc"

	radix decimal

INITIAL_PSTRCON equ 0x1f
EXPECTED_PSTRCON equ INITIAL_PSTRCON & ~MOTOR_PSTRCON_OUTPUT_MASK

	extern isr

	udata
	global adcChannel

adcChannel res 1
expectedMotorFlags res 1

NonMotorAdcChannelTest code
	global testArrange

testArrange:
	fcall initialiseIsr
	fcall initialiseAdc

	banksel adcChannel
	movf adcChannel, W
	fcall setAdcChannel

	banksel ADCON0
	movwf ADCON0
	bsf ADCON0, ADON

ensureAllPwmOutputsAreEnabled:
	banksel PSTRCON
	movlw 0xff
	movwf PSTRCON

saveMotorFlagsForComparison:
	banksel motorFlags
	movf motorFlags, W
	banksel expectedMotorFlags
	movwf expectedMotorFlags

ensureNoMotorCurrentLimitingWillOccur:
	banksel ADRESL
	clrf ADRESL
	clrf ADRESH

flagEndOfAdcConversion:
	banksel PIR1
	bsf PIR1, ADIF

testAct:
	fcall isr

testAssert:
	.aliasForAssert PSTRCON, _a
	.aliasLiteralForAssert EXPECTED_PSTRCON, _b
	.assert "_a == _b, 'Expected PSTRCON to have all motor outputs disabled.'"

	.aliasForAssert motorFlags, _a
	.aliasForAssert expectedMotorFlags, _b
	.assert "_a == _b, 'Expected motorFlags to remain unmodified.'"
	return

	end
