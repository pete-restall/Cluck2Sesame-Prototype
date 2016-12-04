	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Clock.inc"
	#include "TestFixture.inc"

	radix decimal

Timer1AsyncTest code
	global testArrange

testArrange:
	banksel T1CON
	clrf T1CON

testAct:
	fcall initialiseClock

testAssert:
	banksel T1CON
	.assert "(t1con & 0x04) != 0, 'T1CON.T1SYNC is not asynchronous.'"
	return

	end
