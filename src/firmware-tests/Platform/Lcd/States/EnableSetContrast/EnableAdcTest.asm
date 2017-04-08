	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "../../LcdStates.inc"
	#include "../../AdcMocks.inc"
	#include "TestFixture.inc"

	radix decimal

EnableAdcTest code
	global testArrange

testArrange:
	fcall initialiseLcd
	fcall initialiseAdcMocks

testAct:
	setLcdState LCD_STATE_ENABLE_SETCONTRAST
	fcall pollLcd

testAssert:
	banksel calledEnableAdc
	.assert "calledEnableAdc != 0, 'Expected enableAdc() to be called.'"
	return

	end
