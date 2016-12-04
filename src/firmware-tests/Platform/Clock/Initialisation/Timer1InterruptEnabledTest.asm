	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Clock.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global initialPie1

initialPie1 res 1

Timer1InterruptEnabledTest code
	global testArrange

testArrange:
	banksel initialPie1
	movf initialPie1, W
	banksel PIE1
	movwf PIE1

testAct:
	fcall initialiseClock

testAssert:
	banksel initialPie1
	movf initialPie1, W
	iorlw (1 << TMR1IE)
	.aliasWForAssert _a
	.aliasForAssert PIE1, _b
	.assert "_a == _b, 'PIE1 expectation failure.'"
	return

	end
