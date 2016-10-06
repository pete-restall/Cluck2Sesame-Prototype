	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "TestFixture.inc"
	radix decimal

	extern initialiseClock

Timer1PrescalerTest code
	global testArrange

testArrange:
	banksel T1CON
	clrf T1CON

testAct:
	fcall initialiseClock

testAssert:
	.assert "(t1con & 0x30) == 0x30, 'T1CON.T1CKPS* is not 1:8 prescaler.'"
	.done

	end
