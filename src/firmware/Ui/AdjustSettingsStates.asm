	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Flash.inc"
	#include "Lcd.inc"
	#include "States.inc"
	#include "WaitButtonPressState.inc"

	radix decimal

	defineUiState UI_STATE_ADJUSTSETTINGS
		fcall isLcdIdle
		xorlw 0
		btfsc STATUS, Z
		returnFromUiState

		loadFlashAddressOf screen
		fcall putScreenFromFlash

		waitForButtonPress UI_STATE_ADJUSTSETTINGS_LEFT, UI_STATE_ADJUSTSETTINGS_RIGHT, UI_STATE_ADJUSTSETTINGS_ENTER

		returnFromUiState


	defineUiStateInSameSection UI_STATE_ADJUSTSETTINGS_LEFT
		setUiState UI_STATE_VERSION
		returnFromUiState


	defineUiStateInSameSection UI_STATE_ADJUSTSETTINGS_RIGHT
		setUiState UI_STATE_HOME
		returnFromUiState


	defineUiStateInSameSection UI_STATE_ADJUSTSETTINGS_ENTER
		setUiState UI_STATE_SETTINGS
		returnFromUiState

screen:
	da "Adjust Settings "
	da "                "

	end
