	#include "Mcu.inc"
	#include "PollChain.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledPollAfterSunriseSunset

calledPollAfterSunriseSunset res 1

PollAfterSunriseSunsetMock code
	global initialisePollAfterSunriseSunsetMock
	global POLL_AFTER_SUNRISESUNSET

initialisePollAfterSunriseSunsetMock:
	banksel calledPollAfterSunriseSunset
	clrf calledPollAfterSunriseSunset
	return

POLL_AFTER_SUNRISESUNSET:
	mockCalled calledPollAfterSunriseSunset
	return

	end
