	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Buttons.inc"
	#include "TestFixture.inc"
	#include "../PollAfterButtonsMock.inc"

	radix decimal

PollChainTest code
	global testArrange

testArrange:
	fcall initialisePollAfterButtonsMock
	fcall initialiseButtons

testAct:
	fcall pollButtons

testAssert:
	banksel calledPollAfterButtons
	.assert "calledPollAfterButtons != 0, 'Next poll in chain was not called.'"
	return

	end
