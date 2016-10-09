	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Arithmetic32.inc"
	#include "Clock.inc"
	#include "TestFixture.inc"
	radix decimal

    udata
	global numberOfClockPulsesA
	global numberOfClockPulsesB
	global numberOfClockPulsesC
	global numberOfClockPulsesD
    global expectedClockYearBcd
    global expectedClockMonthBcd
    global expectedClockDayBcd
    global expectedClockHourBcd
    global expectedClockMinuteBcd
    global expectedClockSecondBcd

numberOfClockPulsesA res 1
numberOfClockPulsesB res 1
numberOfClockPulsesC res 1
numberOfClockPulsesD res 1
isZero res 1

expectedClockYearBcd res 1
expectedClockMonthBcd res 1
expectedClockDayBcd res 1
expectedClockHourBcd res 1
expectedClockMinuteBcd res 1
expectedClockSecondBcd res 1

Timer1OverflowIncrementsTimeTest code
	global testArrange

testArrange:
	banksel PORTC
	bcf PORTC, 0

	banksel TRISC
	bcf TRISC, 0

	fcall initialiseClock

testAct:
clockPulseLoop:
	banksel PORTC
	bsf PORTC, RC0
	bcf PORTC, RC0

	fcall updateClock

	call decrementNumberOfClockPulses
	btfss STATUS, Z
	goto clockPulseLoop

	fcall updateClock

testAssert:
	.assert "clockYearBcd == expectedClockYearBcd, 'Year mismatch.'"
	.assert "clockMonthBcd == expectedClockMonthBcd, 'Month mismatch.'"
	.assert "clockDayBcd == expectedClockDayBcd, 'Day mismatch.'"
	.assert "clockHourBcd == expectedClockHourBcd, 'Hour mismatch.'"
	.assert "clockMinuteBcd == expectedClockMinuteBcd, 'Minute mismatch.'"
	.assert "clockSecondBcd == expectedClockSecondBcd, 'Second mismatch.'"
	.done

decrementNumberOfClockPulses:
	banksel isZero
	clrf isZero

	call copyNumberOfClockPulsesIntoRa
	call copyNegativeOneIntoRb
	fcall add32

	banksel isZero
	btfsc STATUS, Z
	bsf isZero, 0

	call copyRaIntoNumberOfClockPulses

	banksel isZero
	bcf STATUS, Z
	btfsc isZero, 0
	bsf STATUS, Z

	return

copyNumberOfClockPulsesIntoRa:
	banksel numberOfClockPulsesA
	movf numberOfClockPulsesA, W
	banksel RAA
	movwf RAA

	banksel numberOfClockPulsesB
	movf numberOfClockPulsesB, W
	banksel RAB
	movwf RAB

	banksel numberOfClockPulsesC
	movf numberOfClockPulsesC, W
	banksel RAC
	movwf RAC

	banksel numberOfClockPulsesD
	movf numberOfClockPulsesD, W
	banksel RAD
	movwf RAD

	return

copyNegativeOneIntoRb:
	banksel RBA
	movlw 0xff
	movwf RBA
	movwf RBB
	movwf RBC
	movwf RBD
	return

copyRaIntoNumberOfClockPulses:
	banksel RAA
	movf RAA, W
	banksel numberOfClockPulsesA
	movwf numberOfClockPulsesA

	banksel RAB
	movf RAB, W
	banksel numberOfClockPulsesB
	movwf numberOfClockPulsesB

	banksel RAC
	movf RAC, W
	banksel numberOfClockPulsesC
	movwf numberOfClockPulsesC

	banksel RAD
	movf RAD, W
	banksel numberOfClockPulsesD
	movwf numberOfClockPulsesD

	return

	end
