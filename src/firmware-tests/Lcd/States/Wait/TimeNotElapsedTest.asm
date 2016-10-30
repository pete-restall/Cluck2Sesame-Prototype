	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "WaitState.inc"
	#include "../../LcdStates.inc"
	#include "../../PollAfterLcdMock.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global timer0Seed
	global numberOfTicks

timer0Seed res 1
numberOfTicks res 1
expectedLcdNextState res 1

TimeNotElapsedTest code
	global testArrange

testArrange:
	fcall initialisePollAfterLcdMock
	fcall initialiseLcd

seedLcdNextStateWithAnyValue:
	banksel TMR0
	movf TMR0, W
	banksel lcdNextState
	movwf lcdNextState

seedTimer0:
	banksel OPTION_REG
	movlw 0xff
	movwf OPTION_REG

	banksel timer0Seed
	movf timer0Seed, W
	banksel TMR0
	movwf TMR0

testAct:
	setLcdState LCD_STATE_WAIT
	storeTimer0 LCD_WAIT_PARAM_INITIAL_TICKS

	banksel numberOfTicks
	movf numberOfTicks, W
	decf numberOfTicks
	banksel LCD_WAIT_PARAM_NUMBER_OF_TICKS
	movwf LCD_WAIT_PARAM_NUMBER_OF_TICKS

callPollLcd:
	banksel calledPollAfterLcd
	clrf calledPollAfterLcd
	fcall pollLcd
	.assert "calledPollAfterLcd != 0, 'Next poll in chain was not called.'"
	.assert "lcdState != lcdNextState, 'Expected lcdState != lcdNextState.'"

	banksel TMR0
	incf TMR0

	banksel numberOfTicks
	decfsz numberOfTicks
	goto callPollLcd

	fcall pollLcd

testAssert:
	.aliasLiteralForAssert LCD_STATE_WAIT, _a
	.assert "lcdState == _a, 'Expected lcdState == LCD_STATE_WAIT.'"
	return

	end
