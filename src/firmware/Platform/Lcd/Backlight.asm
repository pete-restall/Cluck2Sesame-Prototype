	#include "Mcu.inc"
	#include "Lcd.inc"
	#include "ShiftRegister.inc"

	radix decimal

Lcd code
	global setLcdBacklightFlag
	global clearLcdBacklightFlag

setLcdBacklightFlag:
	banksel shiftRegisterBuffer
	bsf shiftRegisterBuffer, LCD_BACKLIGHT_EN_BIT
	return

clearLcdBacklightFlag:
	banksel shiftRegisterBuffer
	bcf shiftRegisterBuffer, LCD_BACKLIGHT_EN_BIT
	return

	end
