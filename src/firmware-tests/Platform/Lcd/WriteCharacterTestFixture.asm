	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "TestFixture.inc"

	radix decimal

	extern lcdState
	extern lcdNextState
	extern lcdStateParameter0

	extern testAct

	udata
	global initialW
	global initialLcdState
	global initialLcdNextState
	global initialLcdCommand
	global expectedW
	global expectedLcdState
	global expectedLcdNextState
	global expectedLcdCommand

initialW res 1
initialLcdState res 1
initialLcdNextState res 1
initialLcdCommand res 1
expectedW res 1
expectedLcdState res 1
expectedLcdNextState res 1
expectedLcdCommand res 1

WriteRegisterTestFixture code
	global testArrange

testArrange:
	fcall initialiseLcd

	banksel initialLcdState
	movf initialLcdState, W
	banksel lcdState
	movwf lcdState

	banksel initialLcdNextState
	movf initialLcdNextState, W
	banksel lcdNextState
	movwf lcdNextState

	banksel initialLcdCommand
	movf initialLcdCommand, W
	banksel lcdStateParameter0
	movwf lcdStateParameter0

callTestAct:
	banksel initialW
	movf initialW, W
	fcall testAct

testAssert:
	.aliasWForAssert _a
	.aliasForAssert expectedW, _b
	.assert "_a == _b, 'Return value (W) expectation mismatch.'"

	.aliasForAssert lcdState, _a
	.aliasForAssert expectedLcdState, _b
	.assert "_a == _b, 'Expected lcdState == expectedLcdState.'"

	.aliasForAssert lcdNextState, _a
	.aliasForAssert expectedLcdNextState, _b
	.assert "_a == _b, 'Expected lcdNextState == expectedLcdNextState.'"

	.aliasForAssert lcdStateParameter0, _a
	.aliasForAssert expectedLcdCommand, _b
	.assert "_a == _b, 'Expected lcdStateParameter0 == expectedLcdCommand.'"
	return

	end
