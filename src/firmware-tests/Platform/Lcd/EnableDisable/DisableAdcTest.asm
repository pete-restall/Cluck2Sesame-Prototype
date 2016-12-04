	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "../AdcMocks.inc"
	#include "TestFixture.inc"

	radix decimal

DisableAdcTest code
	global testArrange

testArrange:
	fcall initialiseAdcMocks
	fcall initialiseLcd

	fcall enableLcd

waitUntilLcdIsEnabled:
	fcall pollLcd
	fcall isLcdEnabled
	sublw 0
	btfsc STATUS, Z
	goto waitUntilLcdIsEnabled

testAct:
	fcall disableLcd

testAssert:
	banksel calledDisableAdc
	.assert "calledDisableAdc != 0, 'Expected call to disableAdc().'"
	return

	end
