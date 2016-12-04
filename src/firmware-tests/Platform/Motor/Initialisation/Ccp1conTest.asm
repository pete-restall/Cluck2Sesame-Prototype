	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "TestFixture.inc"

	radix decimal

Ccp1conTest code
	global testArrange

testArrange:
	banksel CCP1CON
	movlw 0xff
	movwf CCP1CON

testAct:
	fcall initialiseMotor

testAssert:
	banksel CCP1CON
	.assert "(ccp1con & 0b11000000) == 0, 'Expected single PWM output (P1A).'"
	.assert "(ccp1con & 0b00110000) == 0, 'Expected duty-cycle LSBs to be cleared.'"
	.assert "(ccp1con & 0b00001111) == 0b00001100, 'Expected PWM pins are all active-high.'"
	return

	end
