	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "PowerManagement.inc"
	#include "Lcd.inc"
	#include "States.inc"

	radix decimal

	defineUiState UI_STATE_WAIT_LCDIDLE
		fcall preventSleep
		fcall isLcdIdle
		xorlw 0
		.setBankFor uiNextState
		movlw UI_STATE_WAIT_LCDIDLE
		btfss STATUS, Z
		movf uiNextState, W
		movwf uiState
		returnFromUiState

	end
