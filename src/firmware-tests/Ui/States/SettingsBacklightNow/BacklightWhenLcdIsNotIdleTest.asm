	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Ui.inc"
	#include "../../UiStates.inc"
	#include "../../../Platform/Lcd/IsLcdIdleStub.inc"
	#include "../../../Platform/Lcd/BacklightMocks.inc"
	#include "TestFixture.inc"

	radix decimal

BacklightWhenLcdIsNotIdleTest code
	global testArrange

testArrange:
	fcall initialiseUi

	movlw 0
	fcall initialiseIsLcdIdleStub

	fcall initialiseLcdBacklightMocks

testAct:
	setUiState UI_STATE_SETTINGS_BACKLIGHTNOW
	fcall pollUi

testAssert:
	banksel calledSetLcdBacklightFlag
	.assert "calledSetLcdBacklightFlag == 0, 'Expected setLcdBacklightFlag() not to be called.'"
	return

	end
