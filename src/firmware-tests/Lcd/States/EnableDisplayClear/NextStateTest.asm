	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "WaitState.inc"
	#include "../../LcdStates.inc"
	#include "TestFixture.inc"

	radix decimal

NUMBER_OF_TICKS_1_52_MS_PLUS_MARGIN equ 13

NextStateTest code
	global testArrange

testArrange:
	fcall initialiseLcd

stopTimer0:
	banksel OPTION_REG
	movlw 0xff
	movwf OPTION_REG

testAct:
	setLcdState LCD_STATE_ENABLE_DISPLAYCLEAR
	fcall pollLcd

testAssert:
	.aliasForAssert lcdState, _a
	.aliasLiteralForAssert LCD_STATE_WAIT, _b
	.assert "_a == _b, 'Expected state to be LCD_STATE_WAIT.'"

	.aliasForAssert lcdNextState, _a
	.aliasLiteralForAssert LCD_STATE_ENABLE_ENTRYMODE, _b
	.assert "_a == _b, 'Expected next state to be LCD_STATE_ENABLE_ENTRYMODE.'"

	.aliasForAssert LCD_WAIT_PARAM_INITIAL_TICKS, _a
	.aliasForAssert TMR0, _b
	.assert "_a == _b, 'Expected initial ticks to be TMR0.'"

	.aliasForAssert LCD_WAIT_PARAM_NUMBER_OF_TICKS, _a
	.aliasLiteralForAssert NUMBER_OF_TICKS_1_52_MS_PLUS_MARGIN, _b
	.assert "_a == _b, 'Expected wait state for more than 1.52ms.'"
	return

	end
