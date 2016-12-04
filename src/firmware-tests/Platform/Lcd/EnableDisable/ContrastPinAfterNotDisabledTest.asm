	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "../../../../firmware/Platform/Lcd/Isr.inc"
	#include "TestFixture.inc"

	radix decimal

ContrastPinAfterNotDisabledTest code
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

	fcall enableLcd

waitUntilLcdIsEnabledAgain:
	fcall pollLcd
	fcall isLcdEnabled
	sublw 0
	btfsc STATUS, Z
	goto waitUntilLcdIsEnabledAgain

testAct:
	banksel LCD_CONTRAST_PORT
	bsf LCD_CONTRAST_PORT, LCD_CONTRAST_PIN
	fcall disableLcd

testAssert:
	banksel LCD_CONTRAST_PORT
	movf LCD_CONTRAST_PORT, W
	andlw LCD_CONTRAST_PIN_MASK

	.aliasWForAssert _a
	.assert "_a != 0, 'Expected contrast pin to be unchanged.'"
	return

	end
