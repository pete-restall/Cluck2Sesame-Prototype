	#define __CLUCK2SESAME_SUNRISESUNSET_INITIALISE_ASM

	#include "Platform.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"
	#include "../SunriseSunset.inc"
	#include "States.inc"

	radix decimal

	extern INITIALISE_AFTER_SUNRISESUNSET

SunriseSunset code
	global initialiseSunriseSunset

initialiseSunriseSunset:
	.safelySetBankFor sunriseSunsetState
	clrf sunriseSunsetState
	clrf latitudeOffset
	clrf longitudeOffset
	clrf sunriseHourBcd
	clrf sunriseMinuteBcd
	clrf sunsetHourBcd
	clrf sunsetMinuteBcd
	tcall INITIALISE_AFTER_SUNRISESUNSET

	end
