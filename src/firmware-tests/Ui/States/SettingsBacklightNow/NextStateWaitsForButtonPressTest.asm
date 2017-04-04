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

NextStateWaitsForButtonPressTest code
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
	.assertStateIs UI_STATE_WAIT_BUTTONPRESS

	.aliasForAssert uiButtonEventBaseState, _a
	.aliasLiteralForAssert UI_STATE_SETTINGS_BACKLIGHTNOW_LEFT, _b
	.assert "_a == _b, 'Expected uiButtonEventBaseState == UI_STATE_SETTINGS_BACKLIGHTNOW_LEFT.'"
	return

	end
