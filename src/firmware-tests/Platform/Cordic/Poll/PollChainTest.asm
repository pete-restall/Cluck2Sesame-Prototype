	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Cordic.inc"
	#include "TestFixture.inc"
	#include "../PollAfterCordicMock.inc"

	radix decimal

PollChainTest code
	global testArrange

testArrange:
	fcall initialisePollAfterCordicMock
	fcall initialiseCordic

testAct:
	fcall pollCordic

testAssert:
	banksel calledPollAfterCordic
	.assert "calledPollAfterCordic != 0, 'Next poll in chain was not called.'"
	return

	end
