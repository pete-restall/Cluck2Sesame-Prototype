	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "ShiftRegister.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global initialShiftRegisterBuffer
	global expectedShiftRegisterBuffer

initialShiftRegisterBuffer res 1
expectedShiftRegisterBuffer res 1

ClearFlagShiftOutTest code
	global testArrange

testArrange:
	fcall initialiseLcd

	banksel initialShiftRegisterBuffer
	movf initialShiftRegisterBuffer, W
	banksel shiftRegisterBuffer
	movwf shiftRegisterBuffer

testAct:
	fcall clearLcdBacklightFlag

testAssert:
	.aliasForAssert shiftRegisterBuffer, _a
	.aliasForAssert expectedShiftRegisterBuffer, _b
	.assert "_a == _b, 'Expected shiftRegisterBuffer == expectedShiftRegisterBuffer.'"
	return

	end
