	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "../LcdStates.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
expectedState res 1

StateAfterEnabledSecondTimeTest code
	global testArrange

testArrange:
	fcall initialiseLcd
	fcall enableLcd

	banksel TMR0
	movf TMR0, W

	banksel expectedState
	movwf expectedState

	banksel lcdState
	movwf lcdState

testAct:
	fcall enableLcd

testAssert:
	.assertStateIsRegister expectedState
	return

	end
