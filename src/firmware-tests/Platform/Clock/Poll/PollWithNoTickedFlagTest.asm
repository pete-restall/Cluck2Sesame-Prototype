	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Clock.inc"
	#include "TestFixture.inc"
	#include "../PollAfterClockMock.inc"

	radix decimal

    udata
    global initialClockYearBcd
    global initialClockMonthBcd
    global initialClockDayBcd
    global initialClockHourBcd
    global initialClockMinuteBcd
    global initialClockSecondBcd

initialClockYearBcd res 1
initialClockMonthBcd res 1
initialClockDayBcd res 1
initialClockHourBcd res 1
initialClockMinuteBcd res 1
initialClockSecondBcd res 1

PollWithNoTickedFlagTest code
	global testArrange

testArrange:
	fcall initialisePollAfterClockMock
	fcall initialiseClock

	banksel initialClockYearBcd
	movf initialClockYearBcd, W
	banksel clockYearBcd
	movwf clockYearBcd

	banksel initialClockMonthBcd
	movf initialClockMonthBcd, W
	banksel clockMonthBcd
	movwf clockMonthBcd

	banksel initialClockDayBcd
	movf initialClockDayBcd, W
	banksel clockDayBcd
	movwf clockDayBcd

	banksel initialClockHourBcd
	movf initialClockHourBcd, W
	banksel clockHourBcd
	movwf clockHourBcd

	banksel initialClockMinuteBcd
	movf initialClockMinuteBcd, W
	banksel clockMinuteBcd
	movwf clockMinuteBcd

	banksel initialClockSecondBcd
	movf initialClockSecondBcd, W
	banksel clockSecondBcd
	movwf clockSecondBcd

testAct:
	fcall pollClock

testAssert:
	.aliasForAssert clockYearBcd, _a
	.aliasForAssert initialClockYearBcd, _b
	.assert "_a == _b, 'Year should not have been modified.'"

	.aliasForAssert clockMonthBcd, _a
	.aliasForAssert initialClockMonthBcd, _b
	.assert "_a == _b, 'Month should not have been modified.'"

	.aliasForAssert clockDayBcd, _a
	.aliasForAssert initialClockDayBcd, _b
	.assert "_a == _b, 'Day should not have been modified.'"

	.aliasForAssert clockHourBcd, _a
	.aliasForAssert initialClockHourBcd, _b
	.assert "_a == _b, 'Hour should not have been modified.'"

	.aliasForAssert clockMinuteBcd, _a
	.aliasForAssert initialClockMinuteBcd, _b
	.assert "_a == _b, 'Minute should not have been modified.'"

	.aliasForAssert clockSecondBcd, _a
	.aliasForAssert initialClockSecondBcd, _b
	.assert "clockSecondBcd == initialClockSecondBcd, 'Second should not have been modified.'"

	banksel calledPollAfterClock
	.assert "calledPollAfterClock != 0, 'Next poll in chain was not called.'"
	return

	end
