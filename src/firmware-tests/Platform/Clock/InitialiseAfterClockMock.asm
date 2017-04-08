	#include "Platform.inc"
	#include "InitialisationChain.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledInitialiseAfterClock

calledInitialiseAfterClock res 1

InitialiseAfterClockMock code
	global initialiseInitialiseAfterClockMock
	global INITIALISE_AFTER_CLOCK

initialiseInitialiseAfterClockMock:
	banksel calledInitialiseAfterClock
	clrf calledInitialiseAfterClock
	return

INITIALISE_AFTER_CLOCK:
	mockCalled calledInitialiseAfterClock
	return

	end
