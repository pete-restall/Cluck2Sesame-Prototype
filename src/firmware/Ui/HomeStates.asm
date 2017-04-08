	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Flash.inc"
	#include "Lcd.inc"
	#include "States.inc"
	#include "WaitButtonPressState.inc"

	radix decimal

	defineUiState UI_STATE_HOME
		fcall isLcdIdle
		xorlw 0
		btfsc STATUS, Z
		returnFromUiState

		loadFlashAddressOf screen
		fcall putScreenFromFlash

		waitForButtonPress UI_STATE_HOME_LEFT, UI_STATE_HOME_RIGHT, UI_STATE_HOME_ENTER

		returnFromUiState


	defineUiStateInSameSection UI_STATE_HOME_LEFT
		setUiState UI_STATE_ADJUSTSETTINGS
		returnFromUiState


	defineUiStateInSameSection UI_STATE_HOME_RIGHT
		setUiState UI_STATE_DOOROVERRIDE
		returnFromUiState


	defineUiStateInSameSection UI_STATE_HOME_ENTER
		setUiState UI_STATE_WAIT_BUTTONPRESS
		returnFromUiState

screen:
	da "20YY-MM-DD HH:MM"
	da "+00C            "

	end
