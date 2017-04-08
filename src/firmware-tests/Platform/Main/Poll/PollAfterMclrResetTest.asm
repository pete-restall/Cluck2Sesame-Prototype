	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "MclrReset.inc"
	#include "TestFixture.inc"
	#include "../PollMockToAssertTest.inc"
	#include "../ResetMocks.inc"

	radix decimal

	extern main

PollAfterMclrResetTest code
	global testArrange
	global testAssert

testArrange:
	fcall initialiseResetMocks
	fcall initialisePollMock

testAct:
	fcall main

testAssert:
	.aliasForAssert calledPollForWork, _a
	.aliasForAssert calledInitialiseAfterMclrReset, _b
	.assert "_a > _b, 'Main did not call pollForWork after MCLR initialisation.'"
	.done

	end
