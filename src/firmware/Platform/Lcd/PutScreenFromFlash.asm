	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Flash.inc"
	#include "Lcd.inc"
	#include "States.inc"

	radix decimal

LCD_LINE_SIZE equ 16
LCD_SCREEN_SIZE equ 2 * LCD_LINE_SIZE

	extern isLcdIdle

Lcd code
	global putScreenFromFlash

putScreenFromFlash:
	call isLcdIdle
	xorlw 0
	btfsc STATUS, Z
	retlw 0

storeFlashPointerAndNumberOfCharactersRemaining:
	.setBankFor EEADR
	movf EEADR, W
	.setBankFor flashPointerLsb
	movwf flashPointerLsb

	.setBankFor EEADRH
	movf EEADRH, W
	.setBankFor flashPointerMsb
	movwf flashPointerMsb

	movlw LCD_SCREEN_SIZE
	movwf numberOfCharactersRemaining

setNextStateAndReturn:
	setLcdState LCD_STATE_DISPLAYCLEAR
	setLcdNextState LCD_STATE_PUTSCREEN_READFLASH
	retlw 1


	defineLcdStateInSameSection LCD_STATE_PUTSCREEN_READFLASH
		.setBankFor flashPointerMsb
		movf flashPointerMsb, W
		.setBankFor EEADRH
		movwf EEADRH

		.setBankFor flashPointerLsb
		movf flashPointerLsb, W
		.setBankFor EEADR
		movwf EEADR

		fcall readFlashWordAsPairOfSevenBitBytes
		storeFlashBytesInto characters

incrementFlashPointer:
		.setBankFor flashPointerLsb
		incf flashPointerLsb
		btfsc STATUS, Z
		incf flashPointerMsb

		setLcdState LCD_STATE_PUTSCREEN_PUTCHAR
		returnFromLcdState


	defineLcdStateInSameSection LCD_STATE_PUTSCREEN_PUTCHAR
		.setBankFor characters
		movf (characters + 0), W
		btfsc numberOfCharactersRemaining, 0
		movf (characters + 1), W

		call writeCharacter

		.setBankFor numberOfCharactersRemaining
		decf numberOfCharactersRemaining
		btfsc numberOfCharactersRemaining, 0
		goto returnFromPutchar

writtenBothCharacters:
		btfsc STATUS, Z
		goto writtenAllCharacters

		movlw LCD_LINE_SIZE
		xorwf numberOfCharactersRemaining, W
		btfsc STATUS, Z
		goto writtenFirstLine

		setLcdState LCD_STATE_PUTSCREEN_READFLASH
		returnFromLcdState

writtenAllCharacters:
		setLcdState LCD_STATE_IDLE
		returnFromLcdState

writtenFirstLine:
		setLcdState LCD_STATE_PUTSCREEN_NEXTLINE

returnFromPutchar:
		returnFromLcdState


	defineLcdStateInSameSection LCD_STATE_PUTSCREEN_NEXTLINE
		movlw LCD_CMD_SETDDRAMADDRESS_LINE2
		call writeRegister
		setLcdState LCD_STATE_PUTSCREEN_READFLASH
		returnFromLcdState

	end
