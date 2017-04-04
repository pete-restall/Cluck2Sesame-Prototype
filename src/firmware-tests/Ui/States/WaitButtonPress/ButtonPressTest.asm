	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Buttons.inc"
	#include "Ui.inc"
	#include "../../UiStates.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global initialButtonFlags
	global initialUiButtonEventBaseState
	global expectedUiState

initialButtonFlags res 1
initialUiButtonEventBaseState res 1
expectedUiState res 1

ButtonPressTest code
	global testArrange

testArrange:
	fcall initialiseUi

	banksel initialButtonFlags
	movf initialButtonFlags, W
	banksel buttonFlags
	movwf buttonFlags

	banksel initialUiButtonEventBaseState
	movf initialUiButtonEventBaseState, W
	banksel uiButtonEventBaseState
	movwf uiButtonEventBaseState

testAct:
	setUiState UI_STATE_WAIT_BUTTONPRESS
	fcall pollUi

testAssert:
	.aliasForAssert uiState, _a
	.aliasForAssert expectedUiState, _b
	.assert "_a == _b, 'Expected uiState == expectedUiState.'"
	return

	end
