	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Ui.inc"
	#include "../../UiStates.inc"
	#include "../../../Platform/Lcd/IsLcdIdleStub.inc"
	#include "../../../Platform/Lcd/BacklightMocks.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global initialIsLcdIdle
	global initialUiState
	global expectedCalledSetLcdBacklightFlag
	global expectedCalledClearLcdBacklightFlag

initialIsLcdIdle res 1
initialUiState res 1
expectedCalledSetLcdBacklightFlag res 1
expectedCalledClearLcdBacklightFlag res 1

BacklightTest code
	global testArrange

testArrange:
	fcall initialiseUi

	banksel initialIsLcdIdle
	movf initialIsLcdIdle, W
	fcall initialiseIsLcdIdleStub

	fcall initialiseLcdBacklightMocks

	banksel initialUiState
	movf initialUiState, W
	banksel uiState
	movwf uiState

testAct:
	fcall pollUi

testAssert:
	.aliasForAssert calledSetLcdBacklightFlag, _a
	.aliasForAssert expectedCalledSetLcdBacklightFlag, _b
	.assert "_a == _b, 'Expectation mismatch for setLcdBacklightFlag().'"

	.aliasForAssert calledClearLcdBacklightFlag, _a
	.aliasForAssert expectedCalledClearLcdBacklightFlag, _b
	.assert "_a == _b, 'Expectation mismatch for clearLcdBacklightFlag().'"
	return

	end
