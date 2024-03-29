	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "../../LcdStates.inc"
	#include "../../PollAfterLcdMock.inc"
	#include "../../../ShiftRegister/IsShiftRegisterEnabledStub.inc"
	#include "../../../Motor/EnableMotorVddMock.inc"
	#include "TestFixture.inc"

	radix decimal

EnableMotorVddWhenShiftRegisterEnabledTest code
	global testArrange

testArrange:
	movlw 1
	fcall initialiseIsShiftRegisterEnabledStub
	fcall initialiseEnableMotorVddMock
	fcall initialisePollAfterLcdMock
	fcall initialiseLcd

testAct:
	setLcdState LCD_STATE_ENABLE_WAITFORSHIFTREGISTER
	fcall pollLcd

testAssert:
	banksel calledEnableMotorVdd
	.assert "calledEnableMotorVdd != 0, 'Expected call to enableMotorVdd().'"

	banksel calledPollAfterLcd
	.assert "calledPollAfterLcd != 0, 'Next poll in chain was not called.'"
	return

	end
