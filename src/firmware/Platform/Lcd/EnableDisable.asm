	#include "Platform.inc"
	#include "TailCalls.inc"
	#include "../ShiftRegister.inc"
	#include "../Adc.inc"
	#include "Lcd.inc"
	#include "States.inc"

	radix decimal

Lcd code
	global enableLcd
	global disableLcd
	global isLcdEnabled

enableLcd:
	.safelySetBankFor enableLcdCount
	movf enableLcdCount
	btfss STATUS, Z
	goto enableLcdDone

	setLcdState LCD_STATE_ENABLE_WAITFORSHIFTREGISTER

enableLcdDone:
	.setBankFor enableLcdCount
	incf enableLcdCount
	tcall enableShiftRegister

disableLcd:
	.safelySetBankFor enableLcdCount
	decfsz enableLcdCount
	goto disableLcdDone

	fcall disableAdc
	setLcdState LCD_STATE_DISABLED

	.setBankFor lcdFlags
	bcf lcdFlags, LCD_FLAG_ENABLED

	.setBankFor LCD_CONTRAST_PORT
	bcf LCD_CONTRAST_PORT, LCD_CONTRAST_PIN

disableLcdDone:
	; TODO: MOTOR VDD ALSO NEEDS TO BE DISABLED (BEFORE THE SHIFT REGISTER IS DISABLED)
	tcall disableShiftRegister

isLcdEnabled:
	.safelySetBankFor lcdFlags
	btfsc lcdFlags, LCD_FLAG_ENABLED
	retlw 1
	retlw 0

	end
