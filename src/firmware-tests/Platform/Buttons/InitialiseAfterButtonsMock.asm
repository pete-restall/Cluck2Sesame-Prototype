	#include "Platform.inc"
	#include "InitialisationChain.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledInitialiseAfterButtons

calledInitialiseAfterButtons res 1

InitialiseAfterButtonsMock code
	global initialiseInitialiseAfterButtonsMock
	global INITIALISE_AFTER_BUTTONS

initialiseInitialiseAfterButtonsMock:
	banksel calledInitialiseAfterButtons
	clrf calledInitialiseAfterButtons
	return

INITIALISE_AFTER_BUTTONS:
	mockCalled calledInitialiseAfterButtons
	return

	end
