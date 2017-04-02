	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "Buttons.inc"
	#include "States.inc"
	#include "WaitButtonPressState.inc"

	radix decimal

Ui code
	global setUiStateForButtonEvents

	defineUiStateInSameSection UI_STATE_WAIT_BUTTONPRESS
		returnFromUiState


setUiStateForButtonEvents:
	banksel uiButtonEventBaseState
	movwf uiButtonEventBaseState
	movlw UI_STATE_WAIT_BUTTONPRESS
	movwf uiState
	return

	end
