	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Ui.inc"
	#include "../../UiStates.inc"
	#include "../../../Platform/Lcd/IsLcdIdleStub.inc"
	#include "../../PollAfterUiMock.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global isLcdIdleResult

isLcdIdleResult res 1

NextPollInChainTest code
	global testArrange

testArrange:
	fcall initialisePollAfterUiMock
	fcall initialiseUi

	banksel isLcdIdleResult
	movf isLcdIdleResult, W
	fcall initialiseIsLcdIdleStub

testAct:
	setUiState UI_STATE_SETTINGS_BACKLIGHTNOW
	fcall pollUi

testAssert:
	banksel calledPollAfterUi
	.assert "calledPollAfterUi != 0, 'Next poll in chain was not called.'"
	return

	end
