	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Clock.inc"
	#include "TestFixture.inc"

	radix decimal

Timer1PrescalerTest code
	global testArrange

testArrange:
	banksel T1CON
	clrf T1CON

testAct:
	fcall initialiseClock

testAssert:
	banksel T1CON
	.assert "(t1con & 0x30) == 0x30, 'T1CON.T1CKPS* is not 1:8 prescaler.'"
	return

	end
