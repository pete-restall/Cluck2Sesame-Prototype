	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Clock.inc"
	#include "TestFixture.inc"
	#include "../PollAfterClockMock.inc"

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
	fcall initialisePollAfterClockMock
	fcall initialiseClock

testAct:
	banksel clockFlags
	bsf clockFlags, CLOCK_FLAG_TICKED
	.assert "(clockFlags & 0x01) == 0x01, 'CLOCK_FLAG_TICKED should be 0x01.'"

	fcall pollClock

testAssert:
	.aliasForAssert clockYearBcd, _a
	.aliasForAssert expectedClockYearBcd, _b
	.assert "_a == _b, 'Year mismatch.'"

	.aliasForAssert clockMonthBcd, _a
	.aliasForAssert expectedClockMonthBcd, _b
	.assert "_a == _b, 'Month mismatch.'"

	.aliasForAssert clockDayBcd, _a
	.aliasForAssert expectedClockDayBcd, _b
	.assert "_a == _b, 'Day mismatch.'"

	.aliasForAssert clockHourBcd, _a
	.aliasForAssert expectedClockHourBcd, _b
	.assert "_a == _b, 'Hour mismatch.'"

	.aliasForAssert clockMinuteBcd, _a
	.aliasForAssert expectedClockMinuteBcd, _b
	.assert "_a == _b, 'Minute mismatch.'"

	.aliasForAssert clockSecondBcd, _a
	.aliasForAssert expectedClockSecondBcd, _b
	.assert "_a == _b, 'Second mismatch.'"

	banksel clockFlags
	.assert "(clockFlags & 0x01) == 0, 'CLOCK_FLAG_TICKED was not reset.'"

	banksel calledPollAfterClock
	.assert "calledPollAfterClock != 0, 'Next poll in chain was not called.'"
	return

	end
