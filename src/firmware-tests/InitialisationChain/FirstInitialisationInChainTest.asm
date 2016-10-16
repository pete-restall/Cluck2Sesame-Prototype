	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "InitialisationChain.inc"
	#include "Clock.inc"
	#include "TestFixture.inc"

	radix decimal

	extern initialiseAfterReset

	global INITIALISE_AFTER_CLOCK
	global initialiseAfterResetAddressHigh
	global initialiseAfterResetAddressLow
	global initialiseClockAddressHigh
	global initialiseClockAddressLow

	udata
initialiseAfterResetAddressHigh res 1
initialiseAfterResetAddressLow res 1
initialiseClockAddressHigh res 1
initialiseClockAddressLow res 1

FirstInitialisationInChainTest code
	global testArrange

testArrange:
storeInitialiseAfterResetAddressHigh:
	banksel initialiseAfterResetAddressHigh
	movlw high initialiseAfterReset
	movwf initialiseAfterResetAddressHigh

storeInitialiseAfterResetAddressLow:
	banksel initialiseAfterResetAddressLow
	movlw low initialiseAfterReset
	movwf initialiseAfterResetAddressLow

storeInitialiseClockAddressHigh:
	banksel initialiseClockAddressHigh
	movlw high initialiseClock
	movwf initialiseClockAddressHigh

storeInitialiseClockAddressLow:
	banksel initialiseClockAddressLow
	movlw low initialiseClock
	movwf initialiseClockAddressLow

testAct:

testAssert:
	.assert "initialiseAfterResetAddressHigh == initialiseClockAddressHigh, 'Expected first initialisation in chain to be initialiseClock.'"
	.assert "initialiseAfterResetAddressLow == initialiseClockAddressLow, 'Expected first initialisation in chain to be initialiseClock.'"
	return

INITIALISE_AFTER_CLOCK:
	return

	end
