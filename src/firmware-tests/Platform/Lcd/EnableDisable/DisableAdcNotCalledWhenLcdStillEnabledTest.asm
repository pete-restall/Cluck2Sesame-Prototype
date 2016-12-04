	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "../AdcMocks.inc"
	#include "TestFixture.inc"

	radix decimal

DisableAdcNotCalledWhenLcdStillEnabledTest code
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

callEnableLcdAgain:
	fcall enableLcd

testAct:
	fcall disableLcd

testAssert:
	banksel calledDisableAdc
	.assert "calledDisableAdc == 0, 'Expected no call to disableAdc() as LCD is still enabled.'"
	return

	end
