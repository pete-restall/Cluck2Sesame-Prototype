	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Clock.inc"
	#include "Cordic.inc"
	#include "SunriseSunset.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global initialLatitudeOffset
	global initialLongitudeOffset
	global initialDayOfYearHigh
	global initialDayOfYearLow
	global expectedSunriseHourBcd
	global expectedSunriseMinuteBcd
	global expectedSunsetHourBcd
	global expectedSunsetMinuteBcd

initialLatitudeOffset res 1
initialLongitudeOffset res 1
initialDayOfYearHigh res 1
initialDayOfYearLow res 1
expectedSunriseHourBcd res 1
expectedSunriseMinuteBcd res 1
expectedSunsetHourBcd res 1
expectedSunsetMinuteBcd res 1

SunriseAndSunsetTimesTest code
	global testArrange

testArrange:
	fcall initialiseCordic
	fcall initialiseSunriseSunset

setDayOfYear:
	banksel initialDayOfYearHigh
	movf initialDayOfYearHigh, W
	banksel dayOfYearHigh
	movwf dayOfYearHigh

	banksel initialDayOfYearLow
	movf initialDayOfYearLow, W
	banksel dayOfYearLow
	movwf dayOfYearLow

setLocation:
	banksel initialLatitudeOffset
	movf initialLatitudeOffset, W
	banksel latitudeOffset
	movwf latitudeOffset

	banksel initialLongitudeOffset
	movf initialLongitudeOffset, W
	banksel longitudeOffset
	movwf longitudeOffset

testAct:
	fcall calculateSunriseAndSunset

waitForCalculationsToComplete:
	fcall pollCordic
	fcall pollSunriseSunset
	fcall areSunriseAndSunsetValid
	xorlw 0
	btfsc STATUS, Z
	goto waitForCalculationsToComplete

testAssert:
	.aliasForAssert sunriseHourBcd, _a
	.aliasForAssert expectedSunriseHourBcd, _b
	.assert "_a == _b, 'Expected sunriseHourBcd == expectedSunriseHourBcd.'"

	.aliasForAssert sunriseMinuteBcd, _a
	.aliasForAssert expectedSunriseMinuteBcd, _b
	.assert "_a == _b, 'Expected sunriseMinuteBcd == expectedSunriseMinuteBcd.'"

	.aliasForAssert sunsetHourBcd, _a
	.aliasForAssert expectedSunsetHourBcd, _b
	.assert "_a == _b, 'Expected sunsetHourBcd == expectedSunsetHourBcd.'"

	.aliasForAssert sunsetMinuteBcd, _a
	.aliasForAssert expectedSunsetMinuteBcd, _b
	.assert "_a == _b, 'Expected sunsetMinuteBcd == expectedSunsetMinuteBcd.'"
	return

	end
