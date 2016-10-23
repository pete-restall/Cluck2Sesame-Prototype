	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Timer0.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global firstTMR0
	global secondTMR0
	global expectedElapsedTicks

firstTMR0 res 1
secondTMR0 res 1
expectedElapsedTicks res 1
startTicks res 1

ElapsedTicksTest code
	global testArrange

testArrange:
	banksel OPTION_REG
	bsf OPTION_REG, T0CS

testAct:
stubTMR0ForFirstValue:
	banksel firstTMR0
	movf firstTMR0, W
	banksel TMR0
	movwf TMR0

	storeTimer0 startTicks

stubTMR0ForSecondValue:
	banksel secondTMR0
	movf secondTMR0, W
	banksel TMR0
	movwf TMR0

calculateNumberOfElapsedTicks:
	movlw 0
	elapsedSinceTimer0 startTicks

testAssert:
	.assert "W == expectedElapsedTicks, 'Elapsed number of ticks expectation failure.'"
	return

	end
