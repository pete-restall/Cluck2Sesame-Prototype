	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"

	radix decimal

	extern INITIALISE_AFTER_SUNRISESUNSET

SunriseSunset code
	global initialiseSunriseSunset

initialiseSunriseSunset:
	tcall INITIALISE_AFTER_SUNRISESUNSET

	end
