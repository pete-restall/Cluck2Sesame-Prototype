	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "../../LcdStates.inc"
	#include "../../../Motor/IsMotorVddEnabledStub.inc"
	#include "../../PollAfterLcdMock.inc"
	#include "TestFixture.inc"

	radix decimal

MotorVddDisabledTest code
	global testArrange

testArrange:
	clrw
	fcall initialiseIsMotorVddEnabledStub
	fcall initialisePollAfterLcdMock
	fcall initialiseLcd

testAct:
	setLcdState LCD_STATE_ENABLE_WAITFORMOTORVDD
	fcall pollLcd

testAssert:
	.aliasForAssert lcdState, _a
	.aliasLiteralForAssert LCD_STATE_ENABLE_WAITFORMOTORVDD, _b
	.assert "_a == _b, 'Expected state to be LCD_STATE_ENABLE_WAITFORMOTORVDD.'"

	banksel calledPollAfterLcd
	.assert "calledPollAfterLcd != 0, 'Next poll in chain was not called.'"
	return

	end
