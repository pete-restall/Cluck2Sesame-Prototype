	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Ui.inc"
	#include "../UiStates.inc"
	#include "../../Platform/Lcd/IsLcdIdleStub.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global initialIsLcdIdle
	global initialUiState
	global expectOptionAndButtonChanges
	global expectOptionSelectionChanges
	global expectedUiOption1Position
	global expectedUiOption2Position
	global expectedUiOption3Position
	global expectedUiSelectedOptionPosition
	global expectedUiButtonEventBaseState

initialIsLcdIdle res 1
initialUiState res 1
expectOptionAndButtonChanges res 1
expectOptionSelectionChanges res 1
expectedUiOption1Position res 1
expectedUiOption2Position res 1
expectedUiOption3Position res 1
expectedUiSelectedOptionPosition res 1
expectedUiButtonEventBaseState res 1

NextStateIsOptionChangedTestFixture code
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

	banksel expectOptionAndButtonChanges
	movf expectOptionAndButtonChanges
	btfss STATUS, Z
	goto testAct

optionAndButtonChangesAreNotExpected:
	banksel uiOption1Position
	movf uiOption1Position, W
	banksel expectedUiOption1Position
	movwf expectedUiOption1Position

	banksel uiOption2Position
	movf uiOption2Position, W
	banksel expectedUiOption2Position
	movwf expectedUiOption2Position

	banksel uiOption3Position
	movf uiOption3Position, W
	banksel expectedUiOption3Position
	movwf expectedUiOption3Position

	banksel uiSelectedOptionPosition
	movf uiSelectedOptionPosition, W
	banksel expectedUiSelectedOptionPosition
	movf expectOptionSelectionChanges
	btfsc STATUS, Z
	movwf expectedUiSelectedOptionPosition

	banksel uiButtonEventBaseState
	movf uiButtonEventBaseState, W
	banksel expectedUiButtonEventBaseState
	movwf expectedUiButtonEventBaseState

testAct:
	fcall pollUi

testAssert:
	.assertStateIs UI_STATE_OPTION_CHANGED

	.aliasForAssert uiOption1Position, _a
	.aliasForAssert expectedUiOption1Position, _b
	.assert "_a == _b, 'Expected uiOption1Position == expectedUiOption1Position.'"

	.aliasForAssert uiOption2Position, _a
	.aliasForAssert expectedUiOption2Position, _b
	.assert "_a == _b, 'Expected uiOption2Position == expectedUiOption2Position.'"

	.aliasForAssert uiOption3Position, _a
	.aliasForAssert expectedUiOption3Position, _b
	.assert "_a == _b, 'Expected uiOption3Position == expectedUiOption3Position.'"

	.aliasForAssert uiSelectedOptionPosition, _a
	.aliasForAssert expectedUiSelectedOptionPosition, _b
	.assert "_a == _b, 'Expected uiSelectedOptionPosition == expectedUiSelectedOptionPosition.'"

	.aliasForAssert uiButtonEventBaseState, _a
	.aliasForAssert expectedUiButtonEventBaseState, _b
	.assert "_a == _b, 'Expected uiButtonEventBaseState == expectedUiButtonEventBaseState.'"

	return

	end
