	#include "Mcu.inc"

	radix decimal

AllButEnableDisableLcdDummies code
	global initialiseLcd
	global isLcdEnabled
	global isLcdIdle
	global pollLcd
	global putScreenFromFlash
	global putCharacter
	global putBcdDigit
	global putBcdDigits
	global setLcdCursorPosition
	global enableLcdBlinkingCursor
	global disableLcdBlinkingCursor
	global setLcdBacklightFlag
	global clearLcdBacklightFlag

initialiseLcd:
isLcdEnabled:
isLcdIdle:
pollLcd:
putScreenFromFlash:
putCharacter:
putBcdDigit:
putBcdDigits:
setLcdCursorPosition:
enableLcdBlinkingCursor:
disableLcdBlinkingCursor:
setLcdBacklightFlag:
clearLcdBacklightFlag:
	return

	end
