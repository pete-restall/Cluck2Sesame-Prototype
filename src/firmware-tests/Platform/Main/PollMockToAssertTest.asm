	#include "Platform.inc"
	#include "TailCalls.inc"
	#include "TestDoubles.inc"

	radix decimal

	extern testAssert

	global calledPollForWork

	udata
calledPollForWork res 1

PollMockToAssertTest code
	global initialisePollMock
	global pollForWork

initialisePollMock:
	banksel calledPollForWork
	clrf calledPollForWork
	return

pollForWork:
	mockCalled calledPollForWork
	tcall testAssert

	end
