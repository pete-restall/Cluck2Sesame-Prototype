	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Ui.inc"
	#include "../../UiStates.inc"
	#include "../../PollAfterUiMock.inc"
	#include "TestFixture.inc"

	radix decimal

NextPollInChainTest code
	global testArrange

testArrange:
	fcall initialisePollAfterUiMock
	fcall initialiseUi

testAct:
	setUiState UI_STATE_BOOT
	fcall pollUi

testAssert:
	banksel calledPollAfterUi
	.assert "calledPollAfterUi != 0, 'Next poll in chain was not called.'"
	return

	end
