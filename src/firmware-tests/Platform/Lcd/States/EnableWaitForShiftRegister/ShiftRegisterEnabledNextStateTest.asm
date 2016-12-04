	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "../../LcdStates.inc"
	#include "../../PollAfterLcdMock.inc"
	#include "../../IsShiftRegisterEnabledStub.inc"
	#include "TestFixture.inc"

	radix decimal

ShiftRegisterEnabledNextStateTest code
	global testArrange

testArrange:
	movlw 1
	fcall initialiseIsShiftRegisterEnabledStub
	fcall initialisePollAfterLcdMock
	fcall initialiseLcd

testAct:
	setLcdState LCD_STATE_ENABLE_WAITFORSHIFTREGISTER
	fcall pollLcd

testAssert:
	.aliasForAssert lcdState, _a
	.aliasLiteralForAssert LCD_STATE_ENABLE_WAITFORMOTORVDD, _b
	.assert "_a == _b, 'Expected state to be LCD_STATE_ENABLE_WAITFORMOTORVDD.'"

	banksel calledPollAfterLcd
	.assert "calledPollAfterLcd != 0, 'Next poll in chain was not called.'"
	return

	end
