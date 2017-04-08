	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "../LcdStates.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
expectedState res 1

StateAfterDisabledNotAsManyTimesAsEnabledTest code
	global testArrange

testArrange:
	fcall initialiseLcd
	fcall enableLcd
	fcall enableLcd

	banksel TMR0
	movf TMR0, W

	banksel expectedState
	movwf expectedState

	banksel lcdState
	movwf lcdState

testAct:
	fcall disableLcd

testAssert:
	.assertStateIsRegister expectedState
	return

	end
