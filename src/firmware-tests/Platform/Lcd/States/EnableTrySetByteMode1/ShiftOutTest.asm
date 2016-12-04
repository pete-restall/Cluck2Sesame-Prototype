	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "../../LcdStates.inc"
	#include "../../ShiftOutMock.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global initialShiftRegisterBuffer
	global expectedShiftOut1
	global expectedShiftOut2
	global expectedShiftOut3

initialShiftRegisterBuffer res 1
expectedShiftOut1 res 1
expectedShiftOut2 res 1
expectedShiftOut3 res 1

ShiftOutTest code
	global testArrange

testArrange:
	fcall initialiseShiftOutMock
	fcall initialiseLcd

	banksel initialShiftRegisterBuffer
	movf initialShiftRegisterBuffer, W
	banksel shiftRegisterBuffer
	movwf shiftRegisterBuffer

testAct:
	setLcdState LCD_STATE_ENABLE_TRYSETBYTEMODE1
	fcall pollLcd

testAssert:
	banksel calledShiftOutCount
	.assert "calledShiftOutCount == 3, 'Expected three calls to shiftOut().'"

	.assertShiftOut 1, expectedShiftOut1
	.assertShiftOut 2, expectedShiftOut2
	.assertShiftOut 3, expectedShiftOut3
	return

	end
