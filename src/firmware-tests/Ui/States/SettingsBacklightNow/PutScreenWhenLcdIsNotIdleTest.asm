	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Ui.inc"
	#include "../../UiStates.inc"
	#include "../../../Platform/Lcd/IsLcdIdleStub.inc"
	#include "../../../Platform/Lcd/PutScreenFromFlashMock.inc"
	#include "TestFixture.inc"

	radix decimal

PutScreenWhenLcdIsNotIdleTest code
	global testArrange

testArrange:
	fcall initialiseUi

	movlw 0
	fcall initialiseIsLcdIdleStub

	fcall initialisePutScreenFromFlashMock

testAct:
	setUiState UI_STATE_SETTINGS_BACKLIGHTNOW
	fcall pollUi

testAssert:
	banksel calledPutScreenFromFlash
	.assert "calledPutScreenFromFlash == 0, 'Expected putScreenFromFlash() not to be called.'"
	return

	end
