	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "InitialisationChain.inc"
	#include "TestFixture.inc"

	radix decimal

	#define INITIALISE_AFTER_FIRST INITIALISE_AFTER_CLOCK

InitialiseAfterFirstInChainDummy code
	global INITIALISE_AFTER_FIRST

INITIALISE_AFTER_FIRST:
	return

	end
