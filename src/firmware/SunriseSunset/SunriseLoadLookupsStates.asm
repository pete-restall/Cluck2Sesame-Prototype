	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Flash.inc"
	#include "SunriseSunset.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_SUNRISE_LOADLOOKUPS
		call loadLookupIndexIntoFlashAddress
		call loadLookupTableEntryFromFlash

		setSunriseSunsetNextState SUN_STATE_SUNRISE_LOADLOOKUPS2
		setSunriseSunsetState SUN_STATE_LOADLOOKUPS
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_SUNRISE_LOADLOOKUPS2
		call loadLookupIndexIntoFlashAddress
		call loadLookupTableEntryFromFlash

		setSunriseSunsetStoreState SUN_STATE_SUNRISE_STOREHOUR
		setSunriseSunsetState SUN_STATE_LOADLOOKUPS3
		returnFromSunriseSunsetState


loadLookupIndexIntoFlashAddress:
	banksel lookupIndexLow
	bcf STATUS, C
	rlf lookupIndexLow, W
	banksel EEADR
	addlw low(sunriseLookupTable)
	movwf EEADR

	banksel EEADRH
	movlw high(sunriseLookupTable)
	movwf EEADRH
	btfsc STATUS, C
	incf EEADRH

	banksel lookupIndexHigh
	rlf lookupIndexHigh, W
	banksel EEADRH
	addwf EEADRH

	return

	end
