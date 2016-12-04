	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "TestFixture.inc"

	radix decimal

	extern lcdState

	udata
	global initialLcdState
	global expectedIsLcdIdle

initialLcdState res 1
expectedIsLcdIdle res 1

IsLcdIdleTest code
	global testArrange

testArrange:
	fcall initialiseLcd

testAct:
	banksel initialLcdState
	movf initialLcdState, W
	banksel lcdState
	movwf lcdState

	fcall isLcdIdle

testAssert:
	banksel expectedIsLcdIdle
	movf expectedIsLcdIdle
	btfss STATUS, Z
	goto assertLcdIsIdleForThisState

assertLcdIsNotIdleForThisState:
	.assert "W == 0, 'Expected isLcdIdle() to return false.'"
	return

assertLcdIsIdleForThisState:
	.assert "W != 0, 'Expected isLcdIdle() to return true.'"
	return

	end
