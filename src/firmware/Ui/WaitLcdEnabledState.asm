	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "PowerManagement.inc"
	#include "Lcd.inc"
	#include "States.inc"

	radix decimal

	defineUiState UI_STATE_WAIT_LCDENABLED
		fcall preventSleep
		fcall isLcdEnabled
		xorlw 0
		.setBankFor uiNextState
		movlw UI_STATE_WAIT_LCDENABLED
		btfss STATUS, Z
		movf uiNextState, W
		movwf uiState
		returnFromUiState

	end
