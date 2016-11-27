	#include "p16f685.inc"
	#include "PollChain.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledPollAfterUi

calledPollAfterUi res 1

PollAfterUiMock code
	global initialisePollAfterUiMock
	global POLL_AFTER_UI

initialisePollAfterUiMock:
	banksel calledPollAfterUi
	clrf calledPollAfterUi
	return

POLL_AFTER_UI:
	mockCalled calledPollAfterUi
	return

	end
