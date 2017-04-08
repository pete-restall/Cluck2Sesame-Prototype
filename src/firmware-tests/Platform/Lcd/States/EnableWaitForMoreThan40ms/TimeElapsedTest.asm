	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Arithmetic32.inc"
	#include "Lcd.inc"
	#include "../../LcdStates.inc"
	#include "../../PollAfterLcdMock.inc"
	#include "TestFixture.inc"

	radix decimal

NUMBER_OF_TICKS_FOR_40MS_PLUS_TEN_PERCENT equ 344
NUMBER_OF_TICKS equ NUMBER_OF_TICKS_FOR_40MS_PLUS_TEN_PERCENT + 1

	udata
	global timer0Seed

timer0Seed res 1

TimeElapsedTest code
	global testArrange

testArrange:
	fcall initialisePollAfterLcdMock
	fcall initialiseLcd

seedTimer0:
	banksel OPTION_REG
	movlw 0xff
	movwf OPTION_REG

	banksel timer0Seed
	movf timer0Seed, W

	banksel TMR0
	movwf TMR0

initialiseCounterToNumberOfTicks:
	banksel RAA
	clrf RAA
	clrf RAB
	movlw high(NUMBER_OF_TICKS)
	movwf RAC
	movlw low(NUMBER_OF_TICKS)
	movwf RAD

initialiseDecrementForNegativeOne:
	movlw 0xff
	movwf RBA
	movwf RBB
	movwf RBC
	movwf RBD

testAct:
	setLcdState LCD_STATE_ENABLE_WAITFORMORETHAN40MS
	fcall pollLcd

callPollLcd:
	banksel calledPollAfterLcd
	clrf calledPollAfterLcd
	fcall pollLcd

	banksel calledPollAfterLcd
	.assert "calledPollAfterLcd != 0, 'Next poll in chain was not called.'"

	.aliasForAssert lcdState, _a
	.aliasLiteralForAssert LCD_STATE_ENABLE_TRYSETBYTEMODE1, _b
	.assert "_a != _b, 'Expected state not to be LCD_STATE_ENABLE_TRYSETBYTEMODE1.'"

	banksel TMR0
	incf TMR0

	fcall add32
	btfss STATUS, Z
	goto callPollLcd

	fcall pollLcd

testAssert:
	banksel calledPollAfterLcd
	.assert "calledPollAfterLcd != 0, 'Next poll in chain was not called.'"

	.aliasForAssert lcdState, _a
	.aliasLiteralForAssert LCD_STATE_ENABLE_TRYSETBYTEMODE1, _b
	.assert "_a == _b, 'Expected state to be LCD_STATE_ENABLE_TRYSETBYTEMODE1.'"
	return

	end
