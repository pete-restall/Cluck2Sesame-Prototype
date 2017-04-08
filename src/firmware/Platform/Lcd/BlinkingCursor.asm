	#include "Platform.inc"
	#include "Lcd.inc"
	#include "States.inc"

	radix decimal

LCD_CMD_BLINKINGCURSOR equ LCD_CMD_DISPLAYON | b'00000011'
LCD_CMD_NOCURSOR equ LCD_CMD_DISPLAYON | b'00000000'

Lcd code
	global enableLcdBlinkingCursor
	global disableLcdBlinkingCursor

enableLcdBlinkingCursor:
	movlw LCD_CMD_BLINKINGCURSOR
	goto writeRegisterFromWWithIdleNextState

disableLcdBlinkingCursor:
	movlw LCD_CMD_NOCURSOR
	goto writeRegisterFromWWithIdleNextState

	end
