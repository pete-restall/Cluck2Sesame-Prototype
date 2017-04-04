	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Ui.inc"
	#include "../../UiStates.inc"
	#include "TestFixture.inc"

	radix decimal

NextStateWaitsForButtonPressTest code
	global testAct

testAct:
	fcall pollUi
	banksel uiState
	movlw UI_STATE_WAIT_BUTTONPRESS
	xorwf uiState, W
	btfss STATUS, Z
	goto testAct
	return

	end
