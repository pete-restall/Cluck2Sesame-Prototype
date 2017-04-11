	#include "Platform.inc"
	#include "TailCalls.inc"
	#include "Timer0.inc"
	#include "Buttons.inc"
	#include "Ui.inc"
	#include "States.inc"
	#include "WaitButtonPressState.inc"

	radix decimal

NUMBER_OF_SLOWTICKS_10S equ 39

Ui code
	global setUiStateForButtonEvents

	defineUiStateInSameSection UI_STATE_WAIT_BUTTONPRESS
		#if (BUTTON_FLAG_PRESSED1 != 0) || (BUTTON_FLAG_PRESSED2 != 1) || (BUTTON_FLAG_PRESSEDBOTH != 2)
		error "Optimisation assumptions made regarding buttonFlags values"
		#endif

		.setBankFor buttonFlags
		movf buttonFlags
		btfss STATUS, Z
		returnFromUiState

		.setBankFor uiState
		movlw UI_STATE_WAIT_BUTTONPRESS2
		movwf uiState

		storeSlowTimer0 uiButtonReleasedTimestamp
		returnFromUiState


	defineUiStateInSameSection UI_STATE_WAIT_BUTTONPRESS2
		.setBankFor buttonFlags
		movf buttonFlags
		btfsc STATUS, Z
		goto buttonStillNotPressed

buttonPressed:
		bcf STATUS, C
		rrf buttonFlags, W

		.setBankFor uiButtonEventBaseState
		addwf uiButtonEventBaseState, W
		movwf uiState
		returnFromUiState

buttonStillNotPressed:
		.knownBank buttonFlags
		.setBankFor uiFlags
		btfsc uiFlags, UI_FLAG_PREVENTSLEEP
		returnFromUiState

		elapsedSinceSlowTimer0 uiButtonReleasedTimestamp
		sublw NUMBER_OF_SLOWTICKS_10S
		btfsc STATUS, C
		returnFromUiState

		.setBankFor uiState
		movlw UI_STATE_SLEEP
		movwf uiState
		returnFromUiState


setUiStateForButtonEvents:
	.safelySetBankFor uiButtonEventBaseState
	movwf uiButtonEventBaseState
	movlw UI_STATE_WAIT_BUTTONPRESS
	movwf uiState
	return

	end
