	#include "Mcu.inc"
	#include "PollChain.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledPollAfterCordic

calledPollAfterCordic res 1

PollAfterCordicMock code
	global initialisePollAfterCordicMock
	global POLL_AFTER_CORDIC

initialisePollAfterCordicMock:
	banksel calledPollAfterCordic
	clrf calledPollAfterCordic
	return

POLL_AFTER_CORDIC:
	mockCalled calledPollAfterCordic
	return

	end
