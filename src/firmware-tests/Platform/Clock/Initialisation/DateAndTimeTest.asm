	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Clock.inc"
	#include "TestFixture.inc"
	#include "../../ResetFlagsStubs.inc"

	radix decimal

	udata
	global isBrownOutReset
	global expectedClockYearBcd
	global expectedClockMonthBcd
	global expectedClockDayBcd
	global expectedClockHourBcd
	global expectedClockMinuteBcd
	global expectedClockSecondBcd
	global expectedDayOfYearHigh
	global expectedDayOfYearLow

isBrownOutReset res 1
expectedClockYearBcd res 1
expectedClockMonthBcd res 1
expectedClockDayBcd res 1
expectedClockHourBcd res 1
expectedClockMinuteBcd res 1
expectedClockSecondBcd res 1
expectedDayOfYearHigh res 1
expectedDayOfYearLow res 1

DateAndTimeTest code
	global testArrange

testArrange:
	banksel isBrownOutReset
	movf isBrownOutReset
	btfsc STATUS, Z
	goto stubNonBrownOutReset

stubBrownOutReset:
	fcall stubIsLastResetDueToBrownOutToReturnTrue
	goto testAct

stubNonBrownOutReset:
	fcall stubIsLastResetDueToBrownOutToReturnFalse

testAct:
	fcall initialiseClock

testAssert:
	.aliasForAssert clockYearBcd, _a
	.aliasForAssert expectedClockYearBcd, _b
	.assert "_a == _b, 'Expected clockYearBcd to be expectedClockYearBcd.'"

	.aliasForAssert clockMonthBcd, _a
	.aliasForAssert expectedClockMonthBcd, _b
	.assert "_a == _b, 'Expected clockMonthBcd to be expectedClockMonthBcd.'"

	.aliasForAssert clockDayBcd, _a
	.aliasForAssert expectedClockDayBcd, _b
	.assert "_a == _b, 'Expected clockDayBcd to be expectedClockDayBcd.'"

	.aliasForAssert clockHourBcd, _a
	.aliasForAssert expectedClockHourBcd, _b
	.assert "_a == _b, 'Expected clockHourBcd to be expectedClockHourBcd.'"

	.aliasForAssert clockMinuteBcd, _a
	.aliasForAssert expectedClockMinuteBcd, _b
	.assert "_a == _b, 'Expected clockMinuteBcd to be expectedClockMinuteBcd.'"

	.aliasForAssert clockSecondBcd, _a
	.aliasForAssert expectedClockSecondBcd, _b
	.assert "_a == _b, 'Expected clockSecondBcd to be expectedClockSecondBcd.'"

	.aliasForAssert dayOfYearHigh, _a
	.aliasForAssert expectedDayOfYearHigh, _b
	.assert "_a == _b, 'Expected dayOfYearHigh to be expectedDayOfYearHigh.'"

	.aliasForAssert dayOfYearLow, _a
	.aliasForAssert expectedDayOfYearLow, _b
	.assert "_a == _b, 'Expected dayOfYearLow to be expectedDayOfYearLow.'"
	return

	end
