	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "../../../../firmware/Platform/Lcd/Lcd.inc"
	#include "../../../../firmware/Platform/Lcd/Isr.inc"
	#include "TestFixture.inc"

	radix decimal

LcdContrastIsDefaultedTest code
	global testArrange

testArrange:
	banksel TMR0
	movf TMR0, W
	banksel lcdContrast
	movwf lcdContrast

testAct:
	fcall initialiseLcd

testAssert:
	.aliasForAssert lcdContrast, _a
	.aliasLiteralForAssert DEFAULT_LCD_CONTRAST, _b
	.assert "_a == _b, 'Expected lcdContrast == DEFAULT_LCD_CONTRAST.'"
	return

	end
