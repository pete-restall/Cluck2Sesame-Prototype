	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Flash.inc"
	#include "Lcd.inc"
	#include "States.inc"
	#include "WaitButtonPressState.inc"

	radix decimal

	defineUiState UI_STATE_VERSION
		fcall isLcdIdle
		xorlw 0
		btfsc STATUS, Z
		returnFromUiState

		loadFlashAddressOf screen
		fcall putScreenFromFlash

		waitForButtonPress UI_STATE_VERSION_LEFT, UI_STATE_VERSION_RIGHT, UI_STATE_VERSION_ENTER

		returnFromUiState


	defineUiStateInSameSection UI_STATE_VERSION_LEFT
		setUiState UI_STATE_DOOROVERRIDE
		returnFromUiState


	defineUiStateInSameSection UI_STATE_VERSION_RIGHT
		setUiState UI_STATE_ADJUSTSETTINGS
		returnFromUiState


	defineUiStateInSameSection UI_STATE_VERSION_ENTER
		setUiState UI_STATE_WAIT_BUTTONPRESS
		returnFromUiState

screen:
	da "  Cluck2Sesame  "
	da "{{FIRMWARE_VER}}"

	end
