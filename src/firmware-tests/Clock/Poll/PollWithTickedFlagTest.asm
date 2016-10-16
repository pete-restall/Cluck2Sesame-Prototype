	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Clock.inc"
	#include "TestFixture.inc"

	radix decimal

    udata
    global expectedClockYearBcd
    global expectedClockMonthBcd
    global expectedClockDayBcd
    global expectedClockHourBcd
    global expectedClockMinuteBcd
    global expectedClockSecondBcd

expectedClockYearBcd res 1
expectedClockMonthBcd res 1
expectedClockDayBcd res 1
expectedClockHourBcd res 1
expectedClockMinuteBcd res 1
expectedClockSecondBcd res 1

PollWithTickedFlagTest code
	global testArrange

testArrange:
	fcall initialiseClock

testAct:
	banksel clockFlags
	bsf clockFlags, CLOCK_FLAG_TICKED
	.assert "(clockFlags & 0x01) == 0x01, 'CLOCK_FLAG_TICKED should be 0x01.'"

	fcall pollClock

testAssert:
	.assert "clockYearBcd == expectedClockYearBcd, 'Year mismatch.'"
	.assert "clockMonthBcd == expectedClockMonthBcd, 'Month mismatch.'"
	.assert "clockDayBcd == expectedClockDayBcd, 'Day mismatch.'"
	.assert "clockHourBcd == expectedClockHourBcd, 'Hour mismatch.'"
	.assert "clockMinuteBcd == expectedClockMinuteBcd, 'Minute mismatch.'"
	.assert "clockSecondBcd == expectedClockSecondBcd, 'Second mismatch.'"
	.assert "(clockFlags & 0x01) == 0, 'CLOCK_FLAG_TICKED was not reset.'"
	return

	end
