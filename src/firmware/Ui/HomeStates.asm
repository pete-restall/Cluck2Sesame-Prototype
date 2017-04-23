	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Flash.inc"
	#include "Clock.inc"
	#include "Lcd.inc"
	#include "Ui.inc"
	#include "States.inc"
	#include "PutBcdStringState.inc"
	#include "WaitButtonPressState.inc"

	radix decimal

SCREEN_DATETIME_YY_POSITION equ LCD_FIRST_LINE | 2
SCREEN_DATETIME_POSITION_INCREMENT equ 3
SCREEN_DATETIME_ELEMENT_COUNT equ 5

	defineUiState UI_STATE_HOME
		loadFlashAddressOf screen
		fcall putScreenFromFlash
		xorlw 0
		btfsc STATUS, Z
		returnFromUiState

		setupPutBcdString clockYearBcd, SCREEN_DATETIME_ELEMENT_COUNT, SCREEN_DATETIME_YY_POSITION, SCREEN_DATETIME_POSITION_INCREMENT

		waitForButtonPress UI_STATE_HOME_LEFT, UI_STATE_HOME_RIGHT, UI_STATE_HOME_ENTER

		.setBankFor uiState
		movf uiState, W
		movwf uiBcdNextState
		movlw UI_STATE_BCD_PUTSTRING
		movwf uiState
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
