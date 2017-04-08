	#include "Platform.inc"
	#include "Lcd.inc"
	#include "States.inc"

	radix decimal

Lcd code
	global setLcdCursorPosition

setLcdCursorPosition:
	iorlw LCD_CMD_SETDDRAMADDRESS
	goto writeRegisterFromWWithIdleNextState

	end
