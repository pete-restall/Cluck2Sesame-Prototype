	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "../LcdStates.inc"
	#include "TestFixture.inc"

	radix decimal

InitialStateTest code
	global testArrange

testArrange:
	movlw 0xff
	banksel lcdState
	movwf lcdState

testAct:
	fcall initialiseLcd

testAssert:
	.assertStateIs LCD_STATE_DISABLED
	return

	end
