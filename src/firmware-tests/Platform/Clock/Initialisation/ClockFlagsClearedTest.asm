	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Clock.inc"
	#include "TestFixture.inc"

	radix decimal

ClockFlagsClearedTest code
	global testArrange

testArrange:
	banksel clockFlags
	movlw 0xff
	movwf clockFlags

testAct:
	fcall initialiseClock

testAssert:
	banksel clockFlags
	.assert "clockFlags == 0, 'Expected clockFlags to be cleared.'"
	return

	end
