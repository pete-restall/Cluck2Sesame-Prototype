	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Flash.inc"
	#include "Lcd.inc"
	#include "States.inc"
	#include "WaitButtonPressState.inc"

	radix decimal

	defineUiState UI_STATE_SETTINGS_OPENCLOSEOFFSETS
		fcall isLcdIdle
		xorlw 0
		btfsc STATUS, Z
		returnFromUiState

		loadFlashAddressOf screen
		fcall putScreenFromFlash

		waitForButtonPress UI_STATE_SETTINGS_OPENCLOSEOFFSETS_LEFT, UI_STATE_SETTINGS_OPENCLOSEOFFSETS_RIGHT, UI_STATE_SETTINGS_OPENCLOSEOFFSETS_ENTER

		returnFromUiState


	defineUiStateInSameSection UI_STATE_SETTINGS_OPENCLOSEOFFSETS_LEFT
		setUiState UI_STATE_WAIT_BUTTONPRESS
		returnFromUiState


	defineUiStateInSameSection UI_STATE_SETTINGS_OPENCLOSEOFFSETS_RIGHT
		setUiState UI_STATE_WAIT_BUTTONPRESS
		returnFromUiState


	defineUiStateInSameSection UI_STATE_SETTINGS_OPENCLOSEOFFSETS_ENTER
		setUiState UI_STATE_SETTINGS_LOCATION
		returnFromUiState

screen:
	da "Open  -00 mins  "
	da "Close +00 mins  "

	end
