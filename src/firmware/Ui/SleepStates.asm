	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "PowerManagement.inc"
	#include "Lcd.inc"
	#include "States.inc"

	radix decimal

	defineUiState UI_STATE_SLEEP
		movlw UI_STATE_ASLEEP
		movwf uiState

		.setBankFor INTCON
		bcf INTCON, RABIF

		fcall disableLcd
		fcall allowSlowClock
		returnFromUiState


	defineUiStateInSameSection UI_STATE_ASLEEP
		.setBankFor INTCON
		btfss INTCON, RABIF
		returnFromUiState

		setUiState UI_STATE_WAKEUP
		fcall preventSleep
		returnFromUiState

	end
