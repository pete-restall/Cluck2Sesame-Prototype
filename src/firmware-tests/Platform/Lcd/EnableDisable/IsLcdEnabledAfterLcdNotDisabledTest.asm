	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "../../../../firmware/Platform/Lcd/Isr.inc"
	#include "TestFixture.inc"

	radix decimal

IsLcdEnabledAfterLcdNotDisabledTest code
	global testArrange

testArrange:
	fcall initialiseLcd
	fcall enableLcd

waitUntilLcdIsEnabled:
	fcall pollLcd
	banksel lcdFlags
	btfss lcdFlags, LCD_FLAG_ENABLED
	goto waitUntilLcdIsEnabled

enableTheLcdAgain:
	fcall enableLcd

waitUntilLcdIsEnabledAgain:
	fcall pollLcd
	banksel lcdFlags
	btfss lcdFlags, LCD_FLAG_ENABLED
	goto waitUntilLcdIsEnabledAgain

testAct:
	fcall disableLcd
	fcall isLcdEnabled

testAssert:
	.aliasWForAssert _a
	.assert "_a != 0, 'Expected isLcdEnabled() to return true.'"
	return

	end
