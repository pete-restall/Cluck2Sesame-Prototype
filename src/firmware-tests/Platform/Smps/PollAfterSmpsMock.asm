	#include "Platform.inc"
	#include "PollChain.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledPollAfterSmps

calledPollAfterSmps res 1

PollAfterSmpsMock code
	global initialisePollAfterSmpsMock
	global POLL_AFTER_SMPS

initialisePollAfterSmpsMock:
	banksel calledPollAfterSmps
	clrf calledPollAfterSmps
	return

POLL_AFTER_SMPS:
	mockCalled calledPollAfterSmps
	return

	end
