	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Buttons.inc"
	#include "Ui.inc"
	#include "../../UiStates.inc"
	#include "../../PollAfterUiMock.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global initialButtonFlags

initialButtonFlags res 1

NextPollInChainTest code
	global testArrange

testArrange:
	fcall initialisePollAfterUiMock
	fcall initialiseUi

	banksel initialButtonFlags
	movf initialButtonFlags, W
	banksel buttonFlags
	movwf buttonFlags

testAct:
	setUiState UI_STATE_WAIT_BUTTONPRESS
	fcall pollUi

testAssert:
	banksel calledPollAfterUi
	.assert "calledPollAfterUi != 0, 'Next poll in chain was not called.'"
	return

	end
