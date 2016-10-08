	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "TestFixture.inc"
	radix decimal

    extern clockYearBcd
    extern clockMonthBcd
    extern clockDayBcd
    extern clockHourBcd
    extern clockMinuteBcd
    extern clockSecondBcd
	extern initialiseClock

    udata
    global expectedClockYearBcd
    global expectedClockMonthBcd
    global expectedClockDayBcd
    global expectedClockHourBcd
    global expectedClockMinuteBcd
    global expectedClockSecondBcd

numberOfPulses res 3
expectedClockYearBcd res 1
expectedClockMonthBcd res 1
expectedClockDayBcd res 1
expectedClockHourBcd res 1
expectedClockMinuteBcd res 1
expectedClockSecondBcd res 1

Timer1OverflowIncrementsTimeTest code
	global testArrange

testArrange:
	banksel numberOfPulses
	clrf numberOfPulses + 2
	clrf numberOfPulses + 1
	clrf numberOfPulses + 0
	bsf numberOfPulses, 0

	banksel PORTC
	bcf PORTC, 0

	banksel TRISC
	bcf TRISC, 0

	fcall initialiseClock

testAct:
	// TODO: Tie RC0 in gpsim script to the TIMER1 input pin, then run:

	for (i = 0; i < numberOfPulses; i++)
	{
		RC0 = 1;
		RC0 = 0;
		updateClockStuff();
	}
	updateClockStuff();

testAssert:
	.assert "clockYearBcd == expectedClockYearBcd, 'Year mismatch.'"
	.assert "clockMonthBcd == expectedClockMonthBcd, 'Month mismatch.'"
	.assert "clockDayBcd == expectedClockDayBcd, 'Day mismatch.'"
	.assert "clockHourBcd == expectedClockHourBcd, 'Hour mismatch.'"
	.assert "clockMinuteBcd == expectedClockMinuteBcd, 'Minute mismatch.'"
	.assert "clockSecondBcd == expectedClockSecondBcd, 'Second mismatch.'"
	.done

	end
