	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "BrownOutReset.inc"
	#include "TestFixture.inc"
	#include "../PollMockToAssertTest.inc"
	#include "../ResetMocks.inc"
	radix decimal

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
	.assert "_a > _b, 'Main did not call pollForWork after BOR initialisation.'"

	.done

	end
