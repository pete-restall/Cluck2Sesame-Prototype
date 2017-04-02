	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Ui.inc"
	#include "../../UiStates.inc"
	#include "../../../Platform/Lcd/IsLcdIdleStub.inc"
	#include "TestFixture.inc"

	radix decimal

NextStateWhenLcdIsNotIdleTest code
	global testArrange

testArrange:
	fcall initialiseUi

	movlw 0
	fcall initialiseIsLcdIdleStub

testAct:
	setUiState UI_STATE_SETTINGS_BACKLIGHTNOW
	fcall pollUi

testAssert:
	.assertStateIs UI_STATE_SETTINGS_BACKLIGHTNOW
	return

	end
