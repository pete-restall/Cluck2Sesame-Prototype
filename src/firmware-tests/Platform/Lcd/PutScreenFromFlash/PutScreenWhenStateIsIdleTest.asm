	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Timer0.inc"
	#include "Lcd.inc"
	#include "States.inc"
	#include "Flash.inc"
	#include "TestFixture.inc"

	radix decimal

PutScreenWhenStateIsIdleTest code
	global testArrange

testArrange:
	fcall initialiseTimer0
	fcall initialiseLcd
	fcall enableLcd

waitUntilLcdIsEnabled:
	fcall pollLcd
	fcall isLcdEnabled
	xorlw 0
	btfsc STATUS, Z
	goto waitUntilLcdIsEnabled

testAct:
	loadFlashAddressOf lcdScreen
	clrw
	fcall putScreenFromFlash

testAssert:
	.assert "W != 0, 'Expected W != 0.'"

	.aliasForAssert lcdState, _a
	.aliasLiteralForAssert LCD_STATE_DISPLAYCLEAR, _b
	.assert "_a == _b, 'Expected lcdState == LCD_STATE_DISPLAYCLEAR.'"

	.aliasForAssert lcdNextState, _a
	.aliasLiteralForAssert LCD_STATE_PUTSCREEN_READFLASH, _b
	.assert "_a == _b, 'Expected lcdState == LCD_STATE_PUTSCREEN_READFLASH.'"
	return

lcdScreen:
lcdScreenLine1 da "This is a simple"
lcdScreenLine2 da "LCD screen test."

	end
