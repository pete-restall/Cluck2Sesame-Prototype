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
setRC0ToDigitalOutput:
	banksel PORTC
	bcf PORTC, 0

	banksel TRISC
	bcf TRISC, 0

	banksel ANSEL
	bcf ANSEL, ANS0

initialiseSut:
	fcall initialiseClock

enableIsr:
	banksel PIR1
	bcf PIR1, TMR1IF

	banksel PIE1
	bsf PIE1, TMR1IE

	banksel INTCON
	bsf INTCON, PEIE
	bsf INTCON, GIE

setTimer1ToUseRC0:
	banksel T1CON
	bcf T1CON, T1OSCEN

testAct:
clockPulseLoop:
	banksel PORTC
	bsf PORTC, RC0
	bcf PORTC, RC0

	fcall pollClock

	call decrementNumberOfClockPulses
	btfss STATUS, Z
	goto clockPulseLoop

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
	return

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
