	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Ui.inc"
	#include "../../UiStates.inc"
	#include "../../../Platform/Lcd/EnableDisableLcdMocks.inc"
	#include "TestFixture.inc"

	radix decimal

EnableLcdTest code
	global testArrange

testArrange:
	fcall initialiseUi
	fcall initialiseEnableAndDisableLcdMocks

testAct:
	setUiState UI_STATE_BOOT
	fcall pollUi

testAssert:
	banksel calledEnableLcdCount
	.assert "calledEnableLcdCount == 1, 'Expected enableLcd() to be called.'"
	return

	end
