	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Ui.inc"
	#include "../UiStates.inc"
	#include "../../Platform/Lcd/IsLcdIdleStub.inc"
	#include "TestFixture.inc"

	radix decimal

	extern testAct

	udata
	global initialIsLcdIdle
	global initialUiState
	global expectUiButtonEventBaseStateChanges
	global expectedUiButtonEventBaseState

initialIsLcdIdle res 1
initialUiState res 1
expectUiButtonEventBaseStateChanges res 1
expectedUiButtonEventBaseState res 1

NextStateWaitsForButtonPressTestFixture code
	global testArrange

testArrange:
	fcall initialiseUi

	banksel initialIsLcdIdle
	movf initialIsLcdIdle, W
	fcall initialiseIsLcdIdleStub

	banksel initialUiState
	movf initialUiState, W
	banksel uiState
	movwf uiState

	banksel expectUiButtonEventBaseStateChanges
	movf expectUiButtonEventBaseStateChanges
	btfss STATUS, Z
	goto callTestActInTest

	banksel uiButtonEventBaseState
	movf uiButtonEventBaseState, W
	banksel expectedUiButtonEventBaseState
	movwf expectedUiButtonEventBaseState

callTestActInTest:
	fcall testAct

testAssert:
	.assertStateIs UI_STATE_WAIT_BUTTONPRESS

	.aliasForAssert uiButtonEventBaseState, _a
	.aliasForAssert expectedUiButtonEventBaseState, _b
	.assert "_a == _b, 'Expected uiButtonEventBaseState == expectedUiButtonEventBaseState.'"
	return

	end
