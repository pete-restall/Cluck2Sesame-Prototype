	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Clock.inc"
	#include "TestFixture.inc"

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

UpdateWithNoTickedFlagTest code
	global testArrange

testArrange:
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
	fcall updateClock

testAssert:
	.assert "clockYearBcd == initialClockYearBcd, 'Year should not have been modified.'"
	.assert "clockMonthBcd == initialClockMonthBcd, 'Month should not have been modified.'"
	.assert "clockDayBcd == initialClockDayBcd, 'Day should not have been modified.'"
	.assert "clockHourBcd == initialClockHourBcd, 'Hour should not have been modified.'"
	.assert "clockMinuteBcd == initialClockMinuteBcd, 'Minute should not have been modified.'"
	.assert "clockSecondBcd == initialClockSecondBcd, 'Second should not have been modified.'"
	.done

	end
