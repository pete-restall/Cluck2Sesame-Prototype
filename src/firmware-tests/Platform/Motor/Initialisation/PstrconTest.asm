	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "TestFixture.inc"

	radix decimal

PstrconTest code
	global testArrange

testArrange:
	banksel TMR0
	movf TMR0, W
	banksel PSTRCON
	movwf PSTRCON

testAct:
	fcall initialiseMotor

testAssert:
	banksel PSTRCON
	.assert "(pstrcon & 0b00010000) == 0b00010000, 'Expected pulse steering synchronisation.'"
	.assert "(pstrcon & 0b11101111) == 0, 'Expected no PWM steering at initialisation time.'"
	return

	end
