	#include "p16f685.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledInitialiseShiftRegisterCount

calledInitialiseShiftRegisterCount res 1

InitialiseShiftRegisterMock code
	global initialiseInitialiseShiftRegisterMock
	global initialiseShiftRegister

initialiseInitialiseShiftRegisterMock:
	banksel calledInitialiseShiftRegisterCount
	clrf calledInitialiseShiftRegisterCount
	return

initialiseShiftRegister:
	mockIncrementCallCounter calledInitialiseShiftRegisterCount
	return

	end
