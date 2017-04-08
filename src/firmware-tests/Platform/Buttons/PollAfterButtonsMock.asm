	#include "Platform.inc"
	#include "PollChain.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledPollAfterButtons

calledPollAfterButtons res 1

PollAfterButtonsMock code
	global initialisePollAfterButtonsMock
	global POLL_AFTER_BUTTONS

initialisePollAfterButtonsMock:
	banksel calledPollAfterButtons
	clrf calledPollAfterButtons
	return

POLL_AFTER_BUTTONS:
	mockCalled calledPollAfterButtons
	return

	end
