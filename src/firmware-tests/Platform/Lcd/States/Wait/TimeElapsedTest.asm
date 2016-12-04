	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "WaitState.inc"
	#include "../../LcdStates.inc"
	#include "../../PollAfterLcdMock.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global timer0Seed
	global timer0Increment
	global numberOfTicks

timer0Seed res 1
timer0Increment res 1
numberOfTicks res 1
numberOfPolls res 1
expectedLcdNextState res 1

TimeElapsedTest code
	global testArrange

testArrange:
	fcall initialisePollAfterLcdMock
	fcall initialiseLcd

adjustNumberOfPollsForLoopStructure:
	banksel numberOfPolls
	decf numberOfPolls

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
	banksel LCD_WAIT_PARAM_NUMBER_OF_TICKS
	movwf LCD_WAIT_PARAM_NUMBER_OF_TICKS

callPollLcd:
	banksel calledPollAfterLcd
	clrf calledPollAfterLcd
	fcall pollLcd

	banksel calledPollAfterLcd
	.assert "calledPollAfterLcd != 0, 'Next poll in chain was not called.'"

	banksel lcdState
	.assert "lcdState != lcdNextState, 'Expected lcdState != lcdNextState.'"

	banksel timer0Increment
	movf timer0Increment, W
	banksel TMR0
	addwf TMR0

	banksel numberOfPolls
	decfsz numberOfPolls
	goto callPollLcd

	fcall pollLcd

testAssert:
	banksel calledPollAfterLcd
	.assert "calledPollAfterLcd != 0, 'Next poll in chain was not called.'"

	banksel lcdState
	.assert "lcdState == lcdNextState, 'Expected lcdState == lcdNextState.'"
	return

	end
