	#include "Platform.inc"
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
	global expectedFirstLcdState
	global expectedSecondLcdState
	global expectedFinalLcdState
	global expectedFirstLcdCommand
	global expectedSecondLcdCommand

initialW res 1
initialLcdState res 1
initialLcdNextState res 1
initialLcdCommand res 1
capturedW res 1
expectedW res 1
expectedFirstLcdState res 1
expectedSecondLcdState res 1
expectedFinalLcdState res 1
expectedFirstLcdCommand res 1
expectedSecondLcdCommand res 1

DoubleWriteTestFixture code
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
	xorlw 0
	banksel capturedW
	movwf capturedW
	btfsc STATUS, Z
	goto assertInitialStateIsUnmodified

testAssert:
assertFirstWrite:
	.aliasForAssert lcdState, _a
	.aliasForAssert expectedFirstLcdState, _b
	.assert "_a == _b, 'Expected lcdState == expectedFirstLcdState.'"

	.aliasForAssert lcdStateParameter0, _a
	.aliasForAssert expectedFirstLcdCommand, _b
	.assert "_a == _b, 'Expected lcdStateParameter0 == expectedFirstLcdCommand.'"

	fcall pollLcd
	fcall pollLcd

assertSecondWrite:
	.aliasForAssert lcdState, _a
	.aliasForAssert expectedSecondLcdState, _b
	.assert "_a == _b, 'Expected lcdState == expectedSecondLcdState.'"

	.aliasForAssert lcdStateParameter0, _a
	.aliasForAssert expectedSecondLcdCommand, _b
	.assert "_a == _b, 'Expected lcdStateParameter0 == expectedSecondLcdCommand.'"

	fcall pollLcd
	goto assertFinalState

assertInitialStateIsUnmodified:
	.aliasForAssert lcdStateParameter0, _a
	.aliasForAssert initialLcdCommand, _b
	.assert "_a == _b, 'Expected lcdStateParameter0 == initialLcdCommand.'"

	.aliasForAssert lcdNextState, _a
	.aliasForAssert initialLcdNextState, _b
	.assert "_a == _b, 'Expected lcdNextState == initialLcdNextState.'"

	banksel initialLcdState
	movf initialLcdState, W
	movwf expectedFinalLcdState

assertFinalState:
	.aliasForAssert capturedW, _a
	.aliasForAssert expectedW, _b
	.assert "_a == _b, 'Return value (W) expectation mismatch.'"

	.aliasForAssert lcdState, _a
	.aliasForAssert expectedFinalLcdState, _b
	.assert "_a == _b, 'Expected lcdState == expectedFinalLcdState.'"
	return

	end
