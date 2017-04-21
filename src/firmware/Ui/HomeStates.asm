	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Flash.inc"
	#include "Clock.inc"
	#include "Lcd.inc"
	#include "Ui.inc"
	#include "States.inc"
	#include "WaitButtonPressState.inc"

	radix decimal

SCREEN_DATETIME_YY_POSITION equ LCD_FIRST_LINE | 2
SCREEN_DATETIME_DONE_POSITION equ SCREEN_DATETIME_YY_POSITION + (5 * 3)

	defineUiState UI_STATE_HOME
		movlw SCREEN_DATETIME_YY_POSITION
		movwf uiDateTimePosition

		movlw clockYearBcd
		movwf uiDateTimePointer

		loadFlashAddressOf screen
		fcall putScreenFromFlash
		xorlw 0
		btfsc STATUS, Z
		returnFromUiState

		waitForLcdIdleThen UI_STATE_HOME_MOVEDATETIME
		returnFromUiState


	defineUiStateInSameSection UI_STATE_HOME_MOVEDATETIME
		waitForLcdIdleThen UI_STATE_HOME_PUTDATETIME

		.setBankFor uiDateTimePosition
		movf uiDateTimePosition, W
		xorlw SCREEN_DATETIME_DONE_POSITION
		btfsc STATUS, Z
		goto putDateTimeComplete

		movlw 3
		addwf uiDateTimePosition
		subwf uiDateTimePosition, W
		fcall setLcdCursorPosition
		returnFromUiState

putDateTimeComplete:
		.knownBank uiDateTimePosition
		waitForButtonPress UI_STATE_HOME_LEFT, UI_STATE_HOME_RIGHT, UI_STATE_HOME_ENTER
		returnFromUiState


	defineUiStateInSameSection UI_STATE_HOME_PUTDATETIME
		waitForLcdIdleThen UI_STATE_HOME_MOVEDATETIME

		.setBankFor uiDateTimePointer
		bankisel clockYearBcd
		movf uiDateTimePointer, W
		incf uiDateTimePointer
		movwf FSR
		movf INDF, W
		fcall putBcdDigits
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
