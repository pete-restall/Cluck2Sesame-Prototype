	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "InitialisationChain.inc"
	#include "TestFixture.inc"

	radix decimal

	extern initialiseAfterReset
	extern INITIALISE_FIRST

	global initialiseAfterResetAddressHigh
	global initialiseAfterResetAddressLow
	global initialiseFirstAddressHigh
	global initialiseFirstAddressLow

	udata
initialiseAfterResetAddressHigh res 1
initialiseAfterResetAddressLow res 1
initialiseFirstAddressHigh res 1
initialiseFirstAddressLow res 1

FirstInitialisationInChainTest code
	global testArrange

testArrange:
storeInitialiseAfterResetAddressHigh:
	banksel initialiseAfterResetAddressHigh
	movlw high(initialiseAfterReset)
	movwf initialiseAfterResetAddressHigh

storeInitialiseAfterResetAddressLow:
	banksel initialiseAfterResetAddressLow
	movlw low(initialiseAfterReset)
	movwf initialiseAfterResetAddressLow

storeInitialiseFirstAddressHigh:
	banksel initialiseFirstAddressHigh
	movlw high(INITIALISE_FIRST)
	movwf initialiseFirstAddressHigh

storeInitialiseFirstAddressLow:
	banksel initialiseFirstAddressLow
	movlw low(INITIALISE_FIRST)
	movwf initialiseFirstAddressLow

testAct:

testAssert:
	.assert "initialiseAfterResetAddressHigh == initialiseFirstAddressHigh, 'Expected first initialisation in chain to be INITIALISE_FIRST.'"
	.assert "initialiseAfterResetAddressLow == initialiseFirstAddressLow, 'Expected first initialisation in chain to be INITIALISE_FIRST.'"
	return

	end
