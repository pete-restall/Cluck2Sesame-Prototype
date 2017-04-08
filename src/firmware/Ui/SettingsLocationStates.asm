	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Flash.inc"
	#include "Lcd.inc"
	#include "States.inc"
	#include "WaitButtonPressState.inc"

	radix decimal

	defineUiState UI_STATE_SETTINGS_LOCATION
		fcall isLcdIdle
		xorlw 0
		btfsc STATUS, Z
		returnFromUiState

		loadFlashAddressOf screen
		fcall putScreenFromFlash

		waitForButtonPress UI_STATE_SETTINGS_LOCATION_LEFT, UI_STATE_SETTINGS_LOCATION_RIGHT, UI_STATE_SETTINGS_LOCATION_ENTER

		returnFromUiState


	defineUiStateInSameSection UI_STATE_SETTINGS_LOCATION_LEFT
		setUiState UI_STATE_WAIT_BUTTONPRESS
		returnFromUiState


	defineUiStateInSameSection UI_STATE_SETTINGS_LOCATION_RIGHT
		setUiState UI_STATE_WAIT_BUTTONPRESS
		returnFromUiState


	defineUiStateInSameSection UI_STATE_SETTINGS_LOCATION_ENTER
		setUiState UI_STATE_SETTINGS_DOORCALIBRATION
		returnFromUiState

screen:
	da "Latitude  +50.0 "
	da "Longitude +00.0 "

	end
