	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "TestFixture.inc"
	radix decimal

	extern initialiseClock

Timer1DrivesExternalCrystalTest code
	global testArrange

testArrange:
	banksel T1CON
	clrf T1CON

testAct:
	fcall initialiseClock

testAssert:
	.assert "(t1con & 0x08) != 0, 'T1CON.T1OSCEN is not enabled.'"
	.done

	end
