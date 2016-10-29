	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "../../LcdStates.inc"
	#include "../../IsShiftRegisterEnabledStub.inc"
	#include "../../PollAfterLcdMock.inc"
	#include "TestFixture.inc"

	radix decimal

ShiftRegisterDisabledTest code
	global testArrange

testArrange:
	clrw
	fcall initialiseIsShiftRegisterEnabledStub
	fcall initialisePollAfterLcdMock
	fcall initialiseLcd

testAct:
	setLcdState LCD_STATE_ENABLE_WAITFORSHIFTREGISTER
	fcall pollLcd

testAssert:
	.aliasLiteralForAssert LCD_STATE_ENABLE_WAITFORSHIFTREGISTER, _a
	.assert "lcdState == _a, 'Expected state to be LCD_STATE_ENABLE_WAITFORSHIFTREGISTER.'"

	.assert "calledPollAfterLcd != 0, 'Next poll in chain was not called.'"
	return

	end
