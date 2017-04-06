	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Flash.inc"
	#include "Lcd.inc"
	#include "States.inc"
	#include "WaitButtonPressState.inc"

	radix decimal

	defineUiState UI_STATE_SETTINGS_DATETIME
		fcall isLcdIdle
		xorlw 0
		btfsc STATUS, Z
		returnFromUiState

		loadFlashAddressOf screen
		fcall putScreenFromFlash

		setButtonPressEventStates UI_STATE_SETTINGS_DATETIME_LEFT, UI_STATE_SETTINGS_DATETIME_RIGHT, UI_STATE_SETTINGS_DATETIME_ENTER

		returnFromUiState


	defineUiStateInSameSection UI_STATE_SETTINGS_DATETIME_LEFT
		returnFromUiState


	defineUiStateInSameSection UI_STATE_SETTINGS_DATETIME_RIGHT
		returnFromUiState


	defineUiStateInSameSection UI_STATE_SETTINGS_DATETIME_ENTER
		returnFromUiState

screen:
	da "Date and Time   "
	da "20YY-MM-DD HH:MM"

	end
