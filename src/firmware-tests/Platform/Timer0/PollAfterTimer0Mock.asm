	#include "Platform.inc"
	#include "PollChain.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledPollAfterTimer0

calledPollAfterTimer0 res 1

PollAfterTimer0Mock code
	global initialisePollAfterTimer0Mock
	global POLL_AFTER_TIMER0

initialisePollAfterTimer0Mock:
	banksel calledPollAfterTimer0
	clrf calledPollAfterTimer0
	return

POLL_AFTER_TIMER0:
	mockCalled calledPollAfterTimer0
	return

	end
