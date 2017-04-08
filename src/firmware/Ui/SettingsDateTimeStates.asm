	#include "Platform.inc"
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

		waitForButtonPress UI_STATE_SETTINGS_DATETIME_LEFT, UI_STATE_SETTINGS_DATETIME_RIGHT, UI_STATE_SETTINGS_DATETIME_ENTER

		returnFromUiState


	defineUiStateInSameSection UI_STATE_SETTINGS_DATETIME_LEFT
		setUiState UI_STATE_WAIT_BUTTONPRESS
		returnFromUiState


	defineUiStateInSameSection UI_STATE_SETTINGS_DATETIME_RIGHT
		setUiState UI_STATE_WAIT_BUTTONPRESS
		returnFromUiState


	defineUiStateInSameSection UI_STATE_SETTINGS_DATETIME_ENTER
		setUiState UI_STATE_SETTINGS_OPENCLOSEOFFSETS
		returnFromUiState

screen:
	da "Date and Time   "
	da "20YY-MM-DD HH:MM"

	end
