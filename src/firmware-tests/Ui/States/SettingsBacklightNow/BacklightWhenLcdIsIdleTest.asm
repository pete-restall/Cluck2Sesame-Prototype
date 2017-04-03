	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Ui.inc"
	#include "../../UiStates.inc"
	#include "../../../Platform/Lcd/IsLcdIdleStub.inc"
	#include "../../../Platform/Lcd/BacklightMocks.inc"
	#include "TestFixture.inc"

	radix decimal

BacklightWhenLcdIsIdleTest code
	global testArrange

testArrange:
	fcall initialiseUi

	movlw 1
	fcall initialiseIsLcdIdleStub

	fcall initialiseLcdBacklightMocks

testAct:
	setUiState UI_STATE_SETTINGS_BACKLIGHTNOW
	fcall pollUi

testAssert:
	.aliasForAssert calledSetLcdBacklightFlag, _a
	.assert "_a == 1, 'Expected setLcdBacklightFlag() to be called.'"
	return

	end
