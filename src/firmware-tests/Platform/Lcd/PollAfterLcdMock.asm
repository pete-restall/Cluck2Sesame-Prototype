	#include "p16f685.inc"
	#include "PollChain.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledPollAfterLcd

calledPollAfterLcd res 1

PollAfterLcdMock code
	global initialisePollAfterLcdMock
	global POLL_AFTER_LCD

initialisePollAfterLcdMock:
	banksel calledPollAfterLcd
	clrf calledPollAfterLcd
	return

POLL_AFTER_LCD:
	mockCalled calledPollAfterLcd
	return

	end
