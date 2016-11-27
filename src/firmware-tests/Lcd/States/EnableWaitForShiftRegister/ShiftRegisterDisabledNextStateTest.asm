	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "../../LcdStates.inc"
	#include "../../IsShiftRegisterEnabledStub.inc"
	#include "../../PollAfterLcdMock.inc"
	#include "TestFixture.inc"

	radix decimal

ShiftRegisterDisabledNextStateTest code
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
	.aliasForAssert lcdState, _a
	.aliasLiteralForAssert LCD_STATE_ENABLE_WAITFORSHIFTREGISTER, _b
	.assert "_a == _b, 'Expected state to be LCD_STATE_ENABLE_WAITFORSHIFTREGISTER.'"

	banksel calledPollAfterLcd
	.assert "calledPollAfterLcd != 0, 'Next poll in chain was not called.'"
	return

	end
