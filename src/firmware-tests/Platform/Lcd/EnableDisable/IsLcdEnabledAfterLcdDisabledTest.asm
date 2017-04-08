	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "../../../../firmware/Platform/Lcd/Isr.inc"
	#include "TestFixture.inc"

	radix decimal

IsLcdEnabledAfterLcdDisabledTest code
	global testArrange

testArrange:
	fcall initialiseLcd
	fcall enableLcd

waitUntilLcdIsEnabled:
	fcall pollLcd
	banksel lcdFlags
	btfss lcdFlags, LCD_FLAG_ENABLED

testAct:
	fcall disableLcd
	fcall isLcdEnabled

testAssert:
	.aliasWForAssert _a
	.assert "_a == 0, 'Expected isLcdEnabled() to return false.'"
	return

	end
