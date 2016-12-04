	#include "Mcu.inc"
	#include "TestDoubles.inc"

	radix decimal

	global calledInitialiseAfterReset

	udata
calledInitialiseAfterReset res 1

InitialiseAfterResetMock code
	global initialiseInitialiseAfterResetMock
	global initialiseAfterReset

initialiseInitialiseAfterResetMock:
	banksel calledInitialiseAfterReset
	clrf calledInitialiseAfterReset
	return

initialiseAfterReset:
	mockCalled calledInitialiseAfterReset
	return

	end
