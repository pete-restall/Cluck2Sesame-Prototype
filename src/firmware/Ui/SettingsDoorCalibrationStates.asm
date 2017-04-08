	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Flash.inc"
	#include "Lcd.inc"
	#include "States.inc"
	#include "WaitButtonPressState.inc"

	radix decimal

LEFT_ARROW equ 0x7f
RIGHT_ARROW equ 0x7e

	defineUiState UI_STATE_SETTINGS_DOORCALIBRATION
		fcall isLcdIdle
		xorlw 0
		btfsc STATUS, Z
		returnFromUiState

		loadFlashAddressOf screen
		fcall putScreenFromFlash

		waitForButtonPress UI_STATE_SETTINGS_DOORCALIBRATION_LEFT, UI_STATE_SETTINGS_DOORCALIBRATION_RIGHT, UI_STATE_SETTINGS_DOORCALIBRATION_ENTER

		returnFromUiState


	defineUiStateInSameSection UI_STATE_SETTINGS_DOORCALIBRATION_LEFT
		setUiState UI_STATE_WAIT_BUTTONPRESS
		returnFromUiState


	defineUiStateInSameSection UI_STATE_SETTINGS_DOORCALIBRATION_RIGHT
		setUiState UI_STATE_WAIT_BUTTONPRESS
		returnFromUiState


	defineUiStateInSameSection UI_STATE_SETTINGS_DOORCALIBRATION_ENTER
		setUiState UI_STATE_HOME
		returnFromUiState

screen:
	da "Open the Door..."
	dw (LEFT_ARROW << 7) | ' '
	da "DOWN      UP"
	dw (' ' << 7) | RIGHT_ARROW

	end
