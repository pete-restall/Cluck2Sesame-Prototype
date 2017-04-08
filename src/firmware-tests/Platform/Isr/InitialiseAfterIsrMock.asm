	#include "Platform.inc"
	#include "InitialisationChain.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledInitialiseAfterIsr

calledInitialiseAfterIsr res 1

InitialiseAfterIsrMock code
	global initialiseInitialiseAfterIsrMock
	global INITIALISE_AFTER_ISR

initialiseInitialiseAfterIsrMock:
	banksel calledInitialiseAfterIsr
	clrf calledInitialiseAfterIsr
	return

INITIALISE_AFTER_ISR:
	mockCalled calledInitialiseAfterIsr
	return

	end
