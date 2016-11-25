	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Flash.inc"
	#include "Lcd.inc"
	#include "States.inc"

	radix decimal

LCD_LINE_SIZE equ 16
LCD_SCREEN_SIZE equ 2 * LCD_LINE_SIZE

	extern isLcdIdle

	udata
flashPointerMsb res 1
flashPointerLsb res 1
numberOfCharactersRemaining res 1
characters res 2

Lcd code
	global putScreenFromFlash

putScreenFromFlash:
	call isLcdIdle
	xorlw 0
	btfsc STATUS, Z
	retlw 0

storeFlashPointerAndNumberOfCharactersRemaining:
	banksel EEADR
	movf EEADR, W
	banksel flashPointerLsb
	movwf flashPointerLsb

	banksel EEADRH
	movf EEADRH, W
	banksel flashPointerMsb
	movwf flashPointerMsb

	movlw LCD_SCREEN_SIZE
	movwf numberOfCharactersRemaining

setNextStateAndReturn:
	setLcdState LCD_STATE_DISPLAYCLEAR
	setLcdNextState LCD_STATE_PUTSCREEN_READFLASH
	retlw 1


	defineLcdStateInSameSection LCD_STATE_PUTSCREEN_READFLASH

		banksel flashPointerMsb
		movf flashPointerMsb, W
		banksel EEADRH
		movwf EEADRH

		banksel flashPointerLsb
		movf flashPointerLsb, W
		banksel EEADR
		movwf EEADR

		fcall readFlashWordAsPairOfSevenBitBytes
		storeFlashWordInto characters

incrementFlashPointer:
		banksel flashPointerLsb
		incf flashPointerLsb
		btfsc STATUS, Z
		incf flashPointerMsb

		setLcdState LCD_STATE_PUTSCREEN_PUTCHAR
		returnFromLcdState


	defineLcdStateInSameSection LCD_STATE_PUTSCREEN_PUTCHAR

		banksel characters
		movf (characters + 0), W
		btfsc numberOfCharactersRemaining, 0
		movf (characters + 1), W

		call writeCharacter

		banksel numberOfCharactersRemaining
		decf numberOfCharactersRemaining
		btfsc numberOfCharactersRemaining, 0
		goto returnFromPutchar

writtenBothCharacters:
		btfsc STATUS, Z
		goto writtenAllCharacters

		movlw LCD_LINE_SIZE
		xorwf numberOfCharactersRemaining
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
