	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "WaitState.inc"
	#include "../../LcdStates.inc"
	#include "TestFixture.inc"

	radix decimal

NUMBER_OF_TICKS_1_52_MS_PLUS_MARGIN equ 13

	udata
expectedNextState res 1

NextStateTest code
	global testArrange

testArrange:
	fcall initialiseLcd

	banksel TMR0
	movf TMR0, W
	banksel expectedNextState
	movwf expectedNextState

stopTimer0:
	banksel OPTION_REG
	movlw 0xff
	movwf OPTION_REG

testAct:
	setLcdNextState expectedNextState
	setLcdState LCD_STATE_DISPLAYCLEAR
	fcall pollLcd

testAssert:
	.aliasForAssert lcdState, _a
	.aliasLiteralForAssert LCD_STATE_WAIT, _b
	.assert "_a == _b, 'Expected state to be LCD_STATE_WAIT.'"

	.aliasForAssert lcdNextState, _a
	.aliasLiteralForAssert expectedNextState, _b
	.assert "_a == _b, 'Expected next state to be unmodified.'"

	.aliasForAssert LCD_WAIT_PARAM_INITIAL_TICKS, _a
	.aliasForAssert TMR0, _b
	.assert "_a == _b, 'Expected initial ticks to be TMR0.'"

	.aliasForAssert LCD_WAIT_PARAM_NUMBER_OF_TICKS, _a
	.aliasLiteralForAssert NUMBER_OF_TICKS_1_52_MS_PLUS_MARGIN, _b
	.assert "_a == _b, 'Expected wait state for more than 1.52ms.'"
	return

	end
