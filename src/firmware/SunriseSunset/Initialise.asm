	#define __CLUCK2SESAME_SUNRISESUNSET_INITIALISE_ASM

	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"
	#include "../SunriseSunset.inc"

	radix decimal

	extern INITIALISE_AFTER_SUNRISESUNSET

SunriseSunset code
	global initialiseSunriseSunset

initialiseSunriseSunset:
	banksel latitudeOffset
	clrf latitudeOffset
	clrf longitudeOffset
	clrf sunriseHourBcd
	clrf sunriseMinuteBcd
	clrf sunsetHourBcd
	clrf sunsetMinuteBcd
	tcall INITIALISE_AFTER_SUNRISESUNSET

	end
