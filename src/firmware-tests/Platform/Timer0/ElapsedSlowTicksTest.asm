	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Timer0.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global firstSlowTmr0
	global secondSlowTmr0
	global expectedElapsedSlowTicks

firstSlowTmr0 res 1
secondSlowTmr0 res 1
expectedElapsedSlowTicks res 1
startSlowTicks res 1

ElapsedSlowTicksTest code
	global testArrange

testArrange:
	banksel OPTION_REG
	bsf OPTION_REG, T0CS

testAct:
stubSlowTmr0ForFirstValue:
	banksel firstSlowTmr0
	movf firstSlowTmr0, W
	banksel slowTmr0
	movwf slowTmr0

	storeSlowTimer0 startSlowTicks

stubSlowTmr0ForSecondValue:
	banksel secondSlowTmr0
	movf secondSlowTmr0, W
	banksel slowTmr0
	Movwf slowTmr0

calculateNumberOfElapsedSlowTicks:
	movlw 0
	elapsedSinceSlowTimer0 startSlowTicks

testAssert:
	banksel expectedElapsedSlowTicks
	.assert "W == expectedElapsedSlowTicks, 'Elapsed number of slow ticks expectation failure.'"
	return

	end
