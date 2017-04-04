	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "Buttons.inc"
	#include "States.inc"
	#include "WaitButtonPressState.inc"

	radix decimal

Ui code
	global setUiStateForButtonEvents

	defineUiStateInSameSection UI_STATE_WAIT_BUTTONPRESS
		#if (BUTTON_FLAG_PRESSED1 != 0) || (BUTTON_FLAG_PRESSED2 != 1)
		error "Optimisation assumptions made regarding buttonFlags values"
		#endif

		banksel buttonFlags
		movf buttonFlags, W
		btfsc STATUS, Z
		goto endOfState

		andlw BUTTON_FLAG_POTENTIALLY1_MASK | BUTTON_FLAG_POTENTIALLY2_MASK
		btfss STATUS, Z
		goto endOfState

		decf buttonFlags, W
		andlw b'00000011'

		banksel uiButtonEventBaseState
		addwf uiButtonEventBaseState, W
		movwf uiState

endOfState:
		returnFromUiState


setUiStateForButtonEvents:
	banksel uiButtonEventBaseState
	movwf uiButtonEventBaseState
	movlw UI_STATE_WAIT_BUTTONPRESS
	movwf uiState
	return

	end
