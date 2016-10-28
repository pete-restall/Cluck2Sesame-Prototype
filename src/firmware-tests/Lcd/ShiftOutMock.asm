	#include "p16f685.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledShiftOutCount

calledShiftOutCount res 1

ShiftOutMock code
	global initialiseShiftOutMock
	global shiftOut

initialiseShiftOutMock:
	banksel calledShiftOutCount
	clrf calledShiftOutCount
	return

shiftOut:
	mockIncrementCallCounter calledShiftOutCount
	return

	end
