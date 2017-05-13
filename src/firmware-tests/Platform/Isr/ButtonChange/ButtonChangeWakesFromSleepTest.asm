	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Isr.inc"
	#include "PowerManagement.inc"
	#include "Buttons.inc"
	#include "TestFixture.inc"

	radix decimal

ButtonChangeWakesFromSleepTest code
	global testArrange

testArrange:
	fcall initialiseIsr
	fcall initialisePowerManagement
	fcall initialiseButtons

waitForStimulusSynchronisation:
	banksel PORTB
	btfsc PORTB, RB6
	goto waitForStimulusSynchronisation

testAct:
	banksel INTCON
	bsf INTCON, GIE

	fcall pollPowerManagement

testAssert:
	banksel STATUS
	btfss STATUS, NOT_PD
	goto assertInterruptOnChangeIsDisabled

assertFailure:
	.assert "false, 'No sleep was executed.'"
	return

assertInterruptOnChangeIsDisabled:
	banksel PORTB
	movlw 1 << RB6
	andwf PORTB, W
	.assert "W != 0, 'Something other than IOC woke the device from sleep.'"

	banksel INTCON
	movlw 1 << RABIE
	andwf INTCON, W
	.assert "W == 0, 'RABIE should not be set.'"
	return

	end
