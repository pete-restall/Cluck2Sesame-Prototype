	#include "Mcu.inc"
	#include "PollChain.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledPollAfterDoor

calledPollAfterDoor res 1

PollAfterDoorMock code
	global initialisePollAfterDoorMock
	global POLL_AFTER_DOOR

initialisePollAfterDoorMock:
	banksel calledPollAfterDoor
	clrf calledPollAfterDoor
	return

POLL_AFTER_DOOR:
	mockCalled calledPollAfterDoor
	return

	end
