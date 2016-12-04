	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "../../../../firmware/Platform/Lcd/Isr.inc"
	#include "TestFixture.inc"

	radix decimal

LcdFlagsAreAllClearedTest code
	global testArrange

testArrange:
	banksel TMR0
	movf TMR0, W
	banksel lcdFlags
	movwf lcdFlags

testAct:
	fcall initialiseLcd

testAssert:
	banksel lcdFlags
	.assert "lcdFlags == 0, 'Expected all lcdFlags to be cleared.'"
	return

	end
