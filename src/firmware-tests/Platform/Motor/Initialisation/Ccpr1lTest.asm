	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "TestFixture.inc"

	radix decimal

Ccpr1lTest code
	global testArrange

testArrange:
	banksel TMR0
	movf TMR0, W
	banksel CCPR1L
	movwf CCPR1L

testAct:
	fcall initialiseMotor

testAssert:
	banksel CCPR1L
	.assert "ccpr1l == 0, 'Expected initialisation set a 0% duty-cycle.'"
	return

	end
