	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Clock.inc"
	#include "TestFixture.inc"
	#include "../../ResetFlagsStubs.inc"

	radix decimal

    udata
    global initialDayOfYearHigh
    global initialDayOfYearLow
    global expectedDayOfYearHigh
    global expectedDayOfYearLow

initialDayOfYearHigh res 1
initialDayOfYearLow res 1
expectedDayOfYearHigh res 1
expectedDayOfYearLow res 1

DayOfYearTest code
	global testArrange

testArrange:
	fcall stubIsLastResetDueToBrownOutToReturnTrue
	fcall initialiseClock

	banksel initialDayOfYearHigh
	movf initialDayOfYearHigh, W
	banksel dayOfYearHigh
	movwf dayOfYearHigh

	banksel initialDayOfYearLow
	movf initialDayOfYearLow, W
	banksel dayOfYearLow
	movwf dayOfYearLow

testAct:
	banksel clockFlags
	bsf clockFlags, CLOCK_FLAG_TICKED
	fcall pollClock

testAssert:
	.aliasForAssert dayOfYearHigh, _a
	.aliasForAssert expectedDayOfYearHigh, _b
	.assert "_a == _b, 'Expected dayOfYearHigh == expectedDayOfYearHigh.'"

	.aliasForAssert dayOfYearLow, _a
	.aliasForAssert expectedDayOfYearLow, _b
	.assert "_a == _b, 'Expected dayOfYearLow == expectedDayOfYearLow.'"
	return

	end
