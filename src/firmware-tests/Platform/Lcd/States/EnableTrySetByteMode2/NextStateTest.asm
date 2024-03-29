	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "WaitState.inc"
	#include "../../LcdStates.inc"
	#include "TestFixture.inc"

	radix decimal

NUMBER_OF_TICKS_100US_PLUS_MARGIN equ 1

NextStateTest code
	global testArrange

testArrange:
	fcall initialiseLcd

stopTimer0:
	banksel OPTION_REG
	movlw 0xff
	movwf OPTION_REG

testAct:
	setLcdState LCD_STATE_ENABLE_TRYSETBYTEMODE2
	fcall pollLcd

testAssert:
	.aliasForAssert lcdState, _a
	.aliasLiteralForAssert LCD_STATE_WAIT, _b
	.assert "_a == _b, 'Expected state to be LCD_STATE_WAIT.'"

	.aliasForAssert lcdNextState, _a
	.aliasLiteralForAssert LCD_STATE_ENABLE_SETBYTEMODE, _b
	.assert "_a == _b, 'Expected next state to be LCD_STATE_ENABLE_SETBYTEMODE.'"

	.aliasForAssert LCD_WAIT_PARAM_INITIAL_TICKS, _a
	.aliasForAssert TMR0, _b
	.assert "_a == _b, 'Expected initial ticks to be TMR0.'"

	.aliasForAssert LCD_WAIT_PARAM_NUMBER_OF_TICKS, _a
	.aliasLiteralForAssert NUMBER_OF_TICKS_100US_PLUS_MARGIN, _b
	.assert "_a == _b, 'Expected wait state for more than 100us.'"
	return

	end
