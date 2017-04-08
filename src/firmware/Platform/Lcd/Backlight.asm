	#include "Platform.inc"
	#include "Lcd.inc"
	#include "ShiftRegister.inc"

	radix decimal

Lcd code
	global setLcdBacklightFlag
	global clearLcdBacklightFlag

setLcdBacklightFlag:
	.safelySetBankFor shiftRegisterBuffer
	bsf shiftRegisterBuffer, LCD_BACKLIGHT_EN_BIT
	return

clearLcdBacklightFlag:
	.safelySetBankFor shiftRegisterBuffer
	bcf shiftRegisterBuffer, LCD_BACKLIGHT_EN_BIT
	return

	end
