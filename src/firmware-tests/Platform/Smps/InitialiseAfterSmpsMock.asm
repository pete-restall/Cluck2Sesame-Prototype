	#include "p16f685.inc"
	#include "InitialisationChain.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledInitialiseAfterSmps

calledInitialiseAfterSmps res 1

InitialiseAfterSmpsMock code
	global initialiseInitialiseAfterSmpsMock
	global INITIALISE_AFTER_SMPS

initialiseInitialiseAfterSmpsMock:
	banksel calledInitialiseAfterSmps
	clrf calledInitialiseAfterSmps
	return

INITIALISE_AFTER_SMPS:
	mockCalled calledInitialiseAfterSmps
	return

	end
