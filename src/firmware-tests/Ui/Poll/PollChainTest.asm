	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Ui.inc"
	#include "TestFixture.inc"
	#include "../PollAfterUiMock.inc"

	radix decimal

PollChainTest code
	global testArrange

testArrange:
	fcall initialisePollAfterUiMock
	fcall initialiseUi

testAct:
	fcall pollUi

testAssert:
	banksel calledPollAfterUi
	.assert "calledPollAfterUi != 0, 'Next poll in chain was not called.'"
	return

	end
