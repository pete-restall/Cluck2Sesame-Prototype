	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "../../../firmware/Lcd/Isr.inc"
	#include "TestFixture.inc"

	radix decimal

ContrastPinAfterDisabledTest code
	global testArrange

testArrange:
	fcall initialiseLcd
	fcall enableLcd

waitUntilLcdIsEnabled:
	fcall pollLcd
	fcall isLcdEnabled
	sublw 0
	btfsc STATUS, Z
	goto waitUntilLcdIsEnabled

testAct:
	banksel LCD_CONTRAST_PORT
	bsf LCD_CONTRAST_PORT, LCD_CONTRAST_PIN
	fcall disableLcd

testAssert:
	banksel LCD_CONTRAST_PORT
	movf LCD_CONTRAST_PORT, W
	andlw LCD_CONTRAST_PIN_MASK

	.aliasWForAssert _a
	.assert "_a == 0, 'Expected contrast pin to be at 0V.'"
	return

	end
