	#ifndef __CLUCK2SESAME_SUNRISESUNSET_INC
	#define __CLUCK2SESAME_SUNRISESUNSET_INC
	#include "Platform.inc"

	radix decimal

	.module SUNRISESUNSET

	.externalVariable latitudeOffset
	.externalVariable longitudeOffset
	.externalVariable sunriseHourBcd
	.externalVariable sunriseMinuteBcd
	.externalVariable sunsetHourBcd
	.externalVariable sunsetMinuteBcd

	#ifndef __CLUCK2SESAME_SUNRISESUNSET_INITIALISE_ASM
	extern initialiseSunriseSunset
	#endif

	extern calculateSunriseAndSunset
	extern pollSunriseSunset
	extern areSunriseAndSunsetValid

	#endif
