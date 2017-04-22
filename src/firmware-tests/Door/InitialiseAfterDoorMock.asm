	#include "Platform.inc"
	#include "InitialisationChain.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledInitialiseAfterDoor

calledInitialiseAfterDoor res 1

InitialiseAfterDoorMock code
	global initialiseInitialiseAfterDoorMock
	global INITIALISE_AFTER_DOOR

initialiseInitialiseAfterDoorMock:
	banksel calledInitialiseAfterDoor
	clrf calledInitialiseAfterDoor
	return

INITIALISE_AFTER_DOOR:
	mockCalled calledInitialiseAfterDoor
	return

	end
