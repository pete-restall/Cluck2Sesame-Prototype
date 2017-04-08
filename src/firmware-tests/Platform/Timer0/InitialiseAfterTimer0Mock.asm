	#include "Platform.inc"
	#include "InitialisationChain.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledInitialiseAfterTimer0

calledInitialiseAfterTimer0 res 1

InitialiseAfterTimer0Mock code
	global initialiseInitialiseAfterTimer0Mock
	global INITIALISE_AFTER_TIMER0

initialiseInitialiseAfterTimer0Mock:
	banksel calledInitialiseAfterTimer0
	clrf calledInitialiseAfterTimer0
	return

INITIALISE_AFTER_TIMER0:
	mockCalled calledInitialiseAfterTimer0
	return

	end
