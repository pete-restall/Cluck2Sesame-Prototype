	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Timer0.inc"
	#include "Lcd.inc"
	#include "States.inc"
	#include "Flash.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global initialLcdState
	global initialLcdNextState

initialLcdState res 1
initialLcdNextState res 1

PutScreenWhenStateIsNotIdleTest code
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

setLcdStateToFixtureValues:
	banksel initialLcdState
	movf initialLcdState, W
	banksel lcdState
	movwf lcdState

	banksel initialLcdNextState
	movf initialLcdNextState, W
	banksel lcdNextState
	movwf lcdNextState

testAct:
	loadFlashAddressOf lcdScreen
	movlw 0xff
	fcall putScreenFromFlash

testAssert:
	.assert "W == 0, 'Expected W == 0.'"

	.aliasForAssert lcdState, _a
	.aliasForAssert initialLcdState, _b
	.assert "_a == _b, 'Expected lcdState == initialLcdState.'"

	.aliasForAssert lcdNextState, _a
	.aliasForAssert initialLcdNextState, _b
	.assert "_a == _b, 'Expected lcdState == initialLcdNextState.'"
	return

lcdScreen:
lcdScreenLine1 da "This is a simple"
lcdScreenLine2 da "LCD screen test."

	end
