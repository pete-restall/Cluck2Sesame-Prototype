	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Clock.inc"
	#include "TestFixture.inc"
	radix decimal

Timer1EnabledTest code
	global testArrange

testArrange:
	banksel T1CON
	clrf T1CON

testAct:
	fcall initialiseClock

testAssert:
	.assert "(t1con & 0x01) != 0, 'T1CON.TMR1ON is not set.'"
	.done

	end
