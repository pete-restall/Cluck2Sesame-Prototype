	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "../../LcdStates.inc"
	#include "../../../ShiftRegister/ShiftOutMock.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global initialShiftRegisterBuffer
	global expectedShiftOut1
	global expectedShiftOut2
	global expectedShiftOut3
	global expectedShiftOut4
	global expectedShiftOut5
	global expectedShiftOut6

initialShiftRegisterBuffer res 1
expectedShiftOut1 res 1
expectedShiftOut2 res 1
expectedShiftOut3 res 1
expectedShiftOut4 res 1
expectedShiftOut5 res 1
expectedShiftOut6 res 1

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
	setLcdState LCD_STATE_ENABLE_SETDISPLAY
	fcall pollLcd

testAssert:
	banksel calledShiftOutCount
	.assert "calledShiftOutCount == 6, 'Expected six calls to shiftOut().'"

	.assertShiftOut 1, expectedShiftOut1
	.assertShiftOut 2, expectedShiftOut2
	.assertShiftOut 3, expectedShiftOut3
	.assertShiftOut 4, expectedShiftOut4
	.assertShiftOut 5, expectedShiftOut5
	.assertShiftOut 6, expectedShiftOut6
	return

	end
