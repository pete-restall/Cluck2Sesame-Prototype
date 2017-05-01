	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Clock.inc"
	#include "TestFixture.inc"
	#include "../../ResetFlagsStubs.inc"

	radix decimal

    udata
    global expectedIsDaylightSavingsTime

expectedIsDaylightSavingsTime res 1

DaylightSavingsTimeTest code
	global testArrange

testArrange:
	fcall stubIsLastResetDueToBrownOutToReturnTrue
	fcall initialiseClock

testAct:
	fcall isDaylightSavingsTime

testAssert:
	banksel expectedIsDaylightSavingsTime
	movf expectedIsDaylightSavingsTime
	btfsc STATUS, Z
	goto assertThatDateIsNotDaylightSavingsTime

assertThatDateIsDaylightSavingsTime:
	.assert "W != 0, 'Expected W != 0 (date is daylight savings time).'"
	return

assertThatDateIsNotDaylightSavingsTime:
	.assert "W == 0, 'Expected W == 0 (date is not daylight savings time).'"
	return

	end
