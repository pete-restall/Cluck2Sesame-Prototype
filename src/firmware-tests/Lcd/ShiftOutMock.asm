	#include "p16f685.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global shiftRegisterBuffer
	global calledShiftOutCount
	global shiftRegisterBufferForCall1
	global shiftRegisterBufferForCall2
	global shiftRegisterBufferForCall3
	global shiftRegisterBufferForCall4

shiftRegisterBuffer res 1
calledShiftOutCount res 1
shiftRegisterBufferForCall1 res 1
shiftRegisterBufferForCall2 res 1
shiftRegisterBufferForCall3 res 1
shiftRegisterBufferForCall4 res 1

ShiftOutMock code
	global initialiseShiftOutMock
	global shiftOut

initialiseShiftOutMock:
	banksel calledShiftOutCount
	clrf calledShiftOutCount
	clrf shiftRegisterBufferForCall1
	clrf shiftRegisterBufferForCall2
	clrf shiftRegisterBufferForCall3
	clrf shiftRegisterBufferForCall4
	return

shiftOut:
pointToNextEntryInCircularBuffer:
	movlw 0x03
	andwf calledShiftOutCount, W
	addlw low(shiftRegisterBufferForCall1)
	movwf FSR

storeShiftRegisterBufferIntoCircularBuffer:
	bankisel shiftRegisterBufferForCall1
	banksel shiftRegisterBuffer
	movf shiftRegisterBuffer, W
	movwf INDF

incrementCallCountAndReturn:
	mockIncrementCallCounter calledShiftOutCount
	return

	end
