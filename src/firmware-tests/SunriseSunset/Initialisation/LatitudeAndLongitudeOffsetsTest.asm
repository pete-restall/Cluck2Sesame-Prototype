	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "SunriseSunset.inc"
	#include "TestFixture.inc"

	radix decimal

LatitudeAndLongitudeOffsetsTest code
	global testArrange

testArrange:
	banksel latitudeOffset
	movf TMR0, W
	movwf latitudeOffset
	movwf longitudeOffset

testAct:
	fcall initialiseSunriseSunset

testAssert:
	banksel latitudeOffset
	.assert "latitudeOffset == 0x00, 'Expected latitudeOffset == 0x00.'"
	.assert "longitudeOffset == 0x00, 'Expected longitudeOffset == 0x00.'"
	return

	end
