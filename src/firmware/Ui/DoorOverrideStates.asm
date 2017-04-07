	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Flash.inc"
	#include "Lcd.inc"
	#include "States.inc"
	#include "WaitButtonPressState.inc"

	radix decimal

	defineUiState UI_STATE_DOOROVERRIDE
		fcall isLcdIdle
		xorlw 0
		btfsc STATUS, Z
		returnFromUiState

		loadFlashAddressOf screen
		fcall putScreenFromFlash

		waitForButtonPress UI_STATE_DOOROVERRIDE_LEFT, UI_STATE_DOOROVERRIDE_RIGHT, UI_STATE_DOOROVERRIDE_ENTER

		returnFromUiState


	defineUiStateInSameSection UI_STATE_DOOROVERRIDE_LEFT
		setUiState UI_STATE_HOME
		returnFromUiState


	defineUiStateInSameSection UI_STATE_DOOROVERRIDE_RIGHT
		setUiState UI_STATE_VERSION
		returnFromUiState


	defineUiStateInSameSection UI_STATE_DOOROVERRIDE_ENTER
		;setUiState UI_STATE_DOOROVERIDE_CHANGE
		setUiState UI_STATE_WAIT_BUTTONPRESS
		returnFromUiState

screen:
	da "Door Override   "
	da " OPEN CLOSE OFF "

	end
