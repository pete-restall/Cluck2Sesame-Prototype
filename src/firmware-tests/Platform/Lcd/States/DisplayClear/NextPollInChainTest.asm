	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "../../LcdStates.inc"
	#include "../../PollAfterLcdMock.inc"
	#include "TestFixture.inc"

	radix decimal

NextPollInChainTest code
	global testArrange

testArrange:
	fcall initialisePollAfterLcdMock
	fcall initialiseLcd

testAct:
	setLcdState LCD_STATE_DISPLAYCLEAR
	fcall pollLcd

testAssert:
	banksel calledPollAfterLcd
	.assert "calledPollAfterLcd != 0, 'Next poll in chain was not called.'"
	return

	end
