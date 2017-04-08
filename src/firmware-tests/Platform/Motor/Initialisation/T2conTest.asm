	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "TestFixture.inc"

	radix decimal

T2conTest code
	global testArrange

testArrange:
	banksel TMR0
	movf TMR0, W
	banksel T2CON
	movwf T2CON

testAct:
	fcall initialiseMotor

testAssert:
	banksel T2CON
	.assert "(t2con & 0b01111000) == 0, 'Expected no post-scaler.'"
	.assert "(t2con & 0b00000100) == 0, 'Expected timer to be off.'"
	.assert "(t2con & 0b00000011) == 0, 'Expected no pre-scaler.'"
	return

	end
