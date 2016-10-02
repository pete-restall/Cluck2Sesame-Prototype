	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "TestFixture.inc"
	radix decimal

	extern calledPollForWork
	extern calledInitialiseAfterBrownOutReset
	extern initialiseResetMocks
	extern initialisePollMock
	extern main

PollAfterBrownOutResetTest code
	global testArrange
	global testAssert

testArrange:
	fcall initialiseResetMocks
	fcall initialisePollMock

testAct:
	fcall main

testAssert:
	.aliasForAssert calledPollForWork, _a
	.aliasForAssert calledInitialiseAfterBrownOutReset, _b
	.assert "_a > _b, \"Main did not call pollForWork after BOR initialisation.\""

	.done

	end
