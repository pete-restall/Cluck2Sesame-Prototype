	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "ShiftRegister.inc"
	#include "TestFixture.inc"

	radix decimal

ShiftRegisterBufferClearedTest code
	global testArrange

testArrange:
	banksel TMR0
	movf TMR0, W
	banksel shiftRegisterBuffer
	movwf shiftRegisterBuffer

testAct:
	fcall initialiseShiftRegister

testAssert:
	banksel shiftRegisterBuffer
	.assert "shiftRegisterBuffer == 0, 'Expected shiftRegisterBuffer to be cleared.'"
	return

	end
