	#include "Mcu.inc"
	#include "InitialisationChain.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledInitialiseAfterUi

calledInitialiseAfterUi res 1

InitialiseAfterUiMock code
	global initialiseInitialiseAfterUiMock
	global INITIALISE_AFTER_UI

initialiseInitialiseAfterUiMock:
	banksel calledInitialiseAfterUi
	clrf calledInitialiseAfterUi
	return

INITIALISE_AFTER_UI:
	mockCalled calledInitialiseAfterUi
	return

	end
