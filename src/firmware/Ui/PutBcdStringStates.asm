	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "Ui.inc"
	#include "States.inc"
	#include "PutBcdStringState.inc"

	radix decimal

	defineUiState UI_STATE_BCD_PUTSTRING
		incf uiBcdCount
		waitForLcdIdleThen UI_STATE_BCD_MOVE
		returnFromUiState


	defineUiStateInSameSection UI_STATE_BCD_MOVE
		decfsz uiBcdCount
		goto moveToNextScreenPosition

allBcdPairsHaveBeenPut:
		movf uiBcdNextState, W
		movwf uiState
		returnFromUiState

moveToNextScreenPosition:
		waitForLcdIdleThen UI_STATE_BCD_PUT

		movf uiBcdIncrement, W
		addwf uiBcdPosition
		subwf uiBcdPosition, W
		fcall setLcdCursorPosition
		returnFromUiState


	defineUiStateInSameSection UI_STATE_BCD_PUT
		waitForLcdIdleThen UI_STATE_BCD_MOVE

		.setBankFor uiFlags
		bcf STATUS, IRP
		btfsc uiFlags, UI_FLAG_PUT_BANKISEL
		bsf STATUS, IRP

		movf uiBcdPointer, W
		incf uiBcdPointer
		movwf FSR
		movf INDF, W
		fcall putBcdDigits
		returnFromUiState

	end
