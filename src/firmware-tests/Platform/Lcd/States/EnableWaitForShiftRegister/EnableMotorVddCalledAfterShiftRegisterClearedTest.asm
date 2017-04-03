	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "../../LcdStates.inc"
	#include "../../../ShiftRegister/IsShiftRegisterEnabledStub.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global initialShiftRegisterBuffer
	global expectedShiftRegisterBuffer
	global shiftRegisterBuffer
	global clearedShiftRegister

initialShiftRegisterBuffer res 1
shiftRegisterBuffer res 1
expectedShiftRegisterBuffer res 1
clearedShiftRegister res 1

EnableMotorVddCalledAfterShiftRegisterClearedTest code
	global testArrange
	global enableMotorVdd
	global shiftOut

testArrange:
	movlw 1
	fcall initialiseIsShiftRegisterEnabledStub
	fcall initialiseLcd

	banksel clearedShiftRegister
	clrf clearedShiftRegister

	movf initialShiftRegisterBuffer, W
	banksel shiftRegisterBuffer
	movwf shiftRegisterBuffer

testAct:
testAssert:
	setLcdState LCD_STATE_ENABLE_WAITFORSHIFTREGISTER
	fcall pollLcd
	return

shiftOut:
	.aliasForAssert shiftRegisterBuffer, _a
	.aliasForAssert expectedShiftRegisterBuffer, _b
	.assert "_a == _b, 'Expected shiftRegisterBuffer == expectedShiftRegisterBuffer.'"

	banksel clearedShiftRegister
	comf clearedShiftRegister
	return

enableMotorVdd:
	banksel clearedShiftRegister
	.assert "clearedShiftRegister != 0, 'Expected shift register to be cleared prior to the enableMotorVdd() call.'"
	return

	end
