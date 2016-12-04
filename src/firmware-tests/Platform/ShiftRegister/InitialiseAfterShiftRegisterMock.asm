	#include "p16f685.inc"
	#include "InitialisationChain.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledInitialiseAfterShiftRegister

calledInitialiseAfterShiftRegister res 1

InitialiseAfterShiftRegisterMock code
	global initialiseInitialiseAfterShiftRegisterMock
	global INITIALISE_AFTER_SHIFTREGISTER

initialiseInitialiseAfterShiftRegisterMock:
	banksel calledInitialiseAfterShiftRegister
	clrf calledInitialiseAfterShiftRegister
	return

INITIALISE_AFTER_SHIFTREGISTER:
	mockCalled calledInitialiseAfterShiftRegister
	return

	end
