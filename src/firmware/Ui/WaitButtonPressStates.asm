	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "Buttons.inc"
	#include "States.inc"
	#include "WaitButtonPressState.inc"

	radix decimal

Ui code
	global setUiStateForButtonEvents

	defineUiStateInSameSection UI_STATE_WAIT_BUTTONPRESS
		#if (BUTTON_FLAG_PRESSED1 != 0) || (BUTTON_FLAG_PRESSED2 != 1) || (BUTTON_FLAG_PRESSEDBOTH != 2)
		error "Optimisation assumptions made regarding buttonFlags values"
		#endif

		banksel buttonFlags
		movf buttonFlags
		btfss STATUS, Z
		returnFromUiState

		banksel uiState
		movlw UI_STATE_WAIT_BUTTONPRESS2
		movwf uiState
		returnFromUiState


	defineUiStateInSameSection UI_STATE_WAIT_BUTTONPRESS2
		banksel buttonFlags
		movf buttonFlags
		btfsc STATUS, Z
		goto endOfState

		bcf STATUS, C
		rrf buttonFlags, W

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
