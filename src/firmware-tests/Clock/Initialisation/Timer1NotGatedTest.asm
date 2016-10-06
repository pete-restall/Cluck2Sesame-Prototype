	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "TestFixture.inc"
	radix decimal

	extern initialiseClock

Timer1NotGatedTest code
	global testArrange

testArrange:
	banksel T1CON
	movlw 0xff
	movwf T1CON

testAct:
	fcall initialiseClock

testAssert:
	.assert "(t1con & 0x40) == 0, 'T1CON.TMR1GE should not be set.'"
	.done

	end