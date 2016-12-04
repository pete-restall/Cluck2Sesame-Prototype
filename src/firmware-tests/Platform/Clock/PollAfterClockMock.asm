	#include "Mcu.inc"
	#include "PollChain.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledPollAfterClock

calledPollAfterClock res 1

PollAfterClockMock code
	global initialisePollAfterClockMock
	global POLL_AFTER_CLOCK

initialisePollAfterClockMock:
	banksel calledPollAfterClock
	clrf calledPollAfterClock
	return

POLL_AFTER_CLOCK:
	mockCalled calledPollAfterClock
	return

	end
