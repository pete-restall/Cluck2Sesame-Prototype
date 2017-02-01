	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "SunriseSunset.inc"
	#include "TestFixture.inc"

	radix decimal

SunriseAndSunsetTimesTest code
	global testArrange

testArrange:
	banksel sunriseHourBcd
	movf TMR0, W
	movwf sunriseHourBcd
	movwf sunriseMinuteBcd
	movwf sunsetHourBcd
	movwf sunsetMinuteBcd

testAct:
	fcall initialiseSunriseSunset

testAssert:
	banksel sunriseHourBcd
	.assert "sunriseHourBcd == 0x00, 'Expected sunriseHour == 0x00.'"
	.assert "sunriseMinuteBcd == 0x00, 'Expected sunriseMinute == 0x00.'"
	.assert "sunsetHourBcd == 0x00, 'Expected sunsetHour == 0x00.'"
	.assert "sunsetMinuteBcd == 0x00, 'Expected sunsetMinute == 0x00.'"
	return

	end
