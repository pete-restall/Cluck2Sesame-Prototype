	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Ui.inc"
	#include "../../UiStates.inc"
	#include "TestFixture.inc"

	radix decimal

NextStateTest code
	global testArrange

testArrange:
	fcall initialiseUi

testAct:
	setUiState UI_STATE_BOOT
	fcall pollUi

testAssert:
	.aliasForAssert uiState, _a
	.aliasLiteralForAssert UI_STATE_SETTINGS, _b
	.assert "_a == _b, 'Expected uiState == UI_STATE_SETTINGS.'"
	return

	end
