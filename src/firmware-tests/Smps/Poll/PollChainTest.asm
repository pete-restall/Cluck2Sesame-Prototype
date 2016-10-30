	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Smps.inc"
	#include "TestFixture.inc"
	#include "../PollAfterSmpsMock.inc"

	radix decimal

PollChainTest code
	global testArrange

testArrange:
	fcall initialisePollAfterSmpsMock
	fcall initialiseSmps

testAct:
	fcall pollSmps

testAssert:
	banksel calledPollAfterSmps
	.assert "calledPollAfterSmps != 0, 'Next poll in chain was not called.'"
	return

	end
