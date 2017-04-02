	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Ui.inc"
	#include "../../UiStates.inc"
	#include "../../../Platform/Lcd/IsLcdIdleStub.inc"
	#include "TestFixture.inc"

	radix decimal

NextStateWhenLcdIsIdleTest code
	global testArrange

testArrange:
	fcall initialiseUi

	movlw 1
	fcall initialiseIsLcdIdleStub

testAct:
	setUiState UI_STATE_SETTINGS_BACKLIGHTNOW
	fcall pollUi

testAssert:
	.assertStateIs UI_STATE_WAIT_BUTTONPRESS

	.aliasForAssert uiButtonEventBaseState, _a
	.aliasLiteralForAssert UI_STATE_SETTINGS_BACKLIGHTNOW_LEFT, _b
	.assert "_a == _b, 'Expected uiButtonEventBaseState == UI_STATE_SETTINGS_BACKLIGHTNOW_LEFT.'"
	return

	end
