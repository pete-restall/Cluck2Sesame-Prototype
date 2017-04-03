	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Ui.inc"
	#include "../../UiStates.inc"
	#include "../../../Platform/Lcd/IsLcdIdleStub.inc"
	#include "../../../Platform/Lcd/PutScreenFromFlashMock.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
initialEeadr res 1
initialEeadrh res 1

PutScreenWhenLcdIsIdleTest code
	global testArrange

testArrange:
	fcall initialiseUi

	movlw 1
	fcall initialiseIsLcdIdleStub

	fcall initialisePutScreenFromFlashMock

	banksel initialEeadr
	movf initialEeadr, W
	banksel EEADR
	movwf EEADR

	banksel initialEeadrh
	movf initialEeadrh, W
	banksel EEADRH
	movwf EEADRH

testAct:
	setUiState UI_STATE_SETTINGS_BACKLIGHTNOW
	fcall pollUi

testAssert:
	.aliasForAssert calledPutScreenFromFlash, _a
	.assert "_a == 1, 'Expected putScreenFromFlash() to be called.'"

	.aliasForAssert calledPutScreenFromFlashEeadr, _a
	.aliasForAssert initialEeadr, _b
	.assert "_a != _b, 'Expected EEADR to be passed into putScreenFromFlash().'"

	.aliasForAssert calledPutScreenFromFlashEeadrh, _a
	.aliasForAssert initialEeadrh, _b
	.assert "_a != _b, 'Expected EEADRH to be passed into putScreenFromFlash().'"
	return

	end
