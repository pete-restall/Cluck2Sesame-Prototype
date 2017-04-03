	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "../../LcdStates.inc"
	#include "../../../ShiftRegister/IsShiftRegisterEnabledStub.inc"
	#include "../../../ShiftRegister/ShiftOutMock.inc"
	#include "TestFixture.inc"

	radix decimal

ShiftRegisterNotClearedBeforeEnabledTest code
	global testArrange

testArrange:
	clrw
	fcall initialiseIsShiftRegisterEnabledStub
	fcall initialiseShiftOutMock
	fcall initialiseLcd

testAct:
	setLcdState LCD_STATE_ENABLE_WAITFORSHIFTREGISTER
	fcall pollLcd

testAssert:
	banksel calledShiftOutCount
	.assert "calledShiftOutCount == 0, 'Expected shiftOut() was not called.'"
	return

	end
