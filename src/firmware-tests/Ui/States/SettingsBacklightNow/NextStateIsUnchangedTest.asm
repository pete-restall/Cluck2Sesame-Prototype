	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Ui.inc"
	#include "../../UiStates.inc"
	#include "../../../Platform/Lcd/IsLcdIdleStub.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global initialIsLcdIdle
	global initialUiState

initialIsLcdIdle res 1
initialUiState res 1

NextStateIsUnchangedTest code
	global testArrange

testArrange:
	fcall initialiseUi

	banksel initialIsLcdIdle
	movf initialIsLcdIdle, W
	fcall initialiseIsLcdIdleStub

	banksel initialUiState
	movf initialUiState, W
	banksel uiState
	movwf uiState

testAct:
	fcall pollUi

testAssert:
	.aliasForAssert uiState, _a
	.aliasForAssert initialUiState, _b
	.assert "_a == _b, 'Expected UI state to be unchanged.'"
	return

	end
