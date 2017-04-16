	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Smps.inc"
	#include "../../ShiftRegister/ShiftOutMock.inc"
	#include "../../ShiftRegister/IsShiftRegisterEnabledStub.inc"
	#include "TestFixture.inc"

	radix decimal

	extern doEnableCall
	extern doDisableCall

	udata
	global initialShiftRegisterBuffer
	global isShiftRegisterEnabledResult
	global numberOfEnableCalls
	global numberOfDisableCalls
	global expectedShiftOutCount
	global expectedShiftRegisterBuffer1
	global expectedShiftRegisterBuffer2
	global expectedShiftRegisterBuffer3
	global expectedShiftRegisterBuffer4
	global expectedShiftRegisterBuffer5
	global expectedShiftRegisterBuffer6
	global expectedShiftRegisterBuffer7
	global expectedShiftRegisterBuffer8

initialShiftRegisterBuffer res 1
isShiftRegisterEnabledResult res 1
numberOfEnableCalls res 1
numberOfDisableCalls res 1
expectedShiftOutCount res 1
expectedShiftRegisterBuffer1 res 1
expectedShiftRegisterBuffer2 res 1
expectedShiftRegisterBuffer3 res 1
expectedShiftRegisterBuffer4 res 1
expectedShiftRegisterBuffer5 res 1
expectedShiftRegisterBuffer6 res 1
expectedShiftRegisterBuffer7 res 1
expectedShiftRegisterBuffer8 res 1

EnableDisableSmpsShiftOutTestFixture code
	global testArrange

testArrange:
	banksel initialShiftRegisterBuffer
	movf initialShiftRegisterBuffer, W
	banksel shiftRegisterBuffer
	movwf shiftRegisterBuffer

	banksel isShiftRegisterEnabledResult
	movf isShiftRegisterEnabledResult, W
	fcall initialiseIsShiftRegisterEnabledStub

	fcall initialiseShiftOutMock
	fcall initialiseSmps

testAct:
	banksel numberOfEnableCalls
	movf numberOfEnableCalls
	btfsc STATUS, Z
	goto callDisableSmps

callEnableSmps:
	fcall doEnableCall
	fcall pollSmps
	banksel numberOfEnableCalls
	decfsz numberOfEnableCalls
	goto callEnableSmps

callDisableSmps:
	banksel numberOfDisableCalls
	movf numberOfDisableCalls
	btfsc STATUS, Z
	goto testAssert

callDisableSmpsInLoop:
	fcall doDisableCall
	fcall pollSmps
	banksel numberOfDisableCalls
	decfsz numberOfDisableCalls
	goto callDisableSmpsInLoop

testAssert:
	.aliasForAssert calledShiftOutCount, _a
	.aliasForAssert expectedShiftOutCount, _b
	.assert "_a == _b, 'Expected shiftOut() count mismatch.'"

assertShiftRegisterBufferContents:
	variable i = 0
	while (i < 8)
		banksel calledShiftOutCount
		movlw i
		xorwf calledShiftOutCount, W
		btfsc STATUS, Z
		return

		.aliasForAssert shiftRegisterBufferForCall1 + i, _a
		.aliasForAssert expectedShiftRegisterBuffer1 + i, _b
		.command "_a"
		.assert "_a == _b, 'Expected shiftRegisterBuffer mismatch.'"

i = i + 1
	endw

	return

	end
