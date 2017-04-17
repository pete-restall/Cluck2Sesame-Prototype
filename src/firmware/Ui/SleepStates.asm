	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "PowerManagement.inc"
	#include "Smps.inc"
	#include "Lcd.inc"
	#include "States.inc"

	radix decimal

	defineUiState UI_STATE_SLEEP
		movlw UI_STATE_WAIT_UNTILCANSLEEP
		movwf uiState

		.setBankFor INTCON
		bcf INTCON, RABIF

		fcall disableLcd
		fcall disableSmps
		fcall allowSlowClock
		returnFromUiState


	defineUiStateInSameSection UI_STATE_WAIT_UNTILCANSLEEP
		fcall preventSleep

		fcall isLcdEnabled
		xorlw 0
		btfss STATUS, Z
		returnFromUiState

		fcall isSmpsEnabled
		xorlw 0
		btfss STATUS, Z
		returnFromUiState

		.setBankFor uiState
		movlw UI_STATE_ASLEEP
		movwf uiState

		returnFromUiState


	defineUiStateInSameSection UI_STATE_ASLEEP
		.setBankFor INTCON
		btfss INTCON, RABIF
		returnFromUiState

		setUiState UI_STATE_WAKEUP
		fcall preventSleep
		fcall enableSmps
		returnFromUiState

	end
