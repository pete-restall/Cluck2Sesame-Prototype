	#include "Mcu.inc"
	#include "InitialisationChain.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledInitialiseAfterCordic

calledInitialiseAfterCordic res 1

InitialiseAfterCordicMock code
	global initialiseInitialiseAfterCordicMock
	global INITIALISE_AFTER_CORDIC

initialiseInitialiseAfterCordicMock:
	banksel calledInitialiseAfterCordic
	clrf calledInitialiseAfterCordic
	return

INITIALISE_AFTER_CORDIC:
	mockCalled calledInitialiseAfterCordic
	return

	end
