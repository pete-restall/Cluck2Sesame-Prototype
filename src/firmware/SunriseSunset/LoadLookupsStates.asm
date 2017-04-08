	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "SunriseSunset.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_LOADLOOKUPS
storeReferenceMinuteWordFromTwoPartialBytesInEntry:
		call mergeLookupEntryReferenceMinute
		movwf lookupReferenceMinuteLow
		movf lookupEntryReferenceMinuteHigh, W
		movwf lookupReferenceMinuteHigh

storeReferenceDeltaMinutesFromEntry:
		movf lookupEntryReferenceDeltaMinutesNorth, W
		movwf lookupReferenceDeltaMinutesNorth
		movf lookupEntryReferenceDeltaMinutesSouth, W
		movwf lookupReferenceDeltaMinutesSouth

		setSunriseSunsetState SUN_STATE_LOADLOOKUPS2
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_LOADLOOKUPS2
incrementIndexToNextEntryInLookupTable:
		.setBankFor lookupIndexHigh
		incf lookupIndexHigh
		incfsz lookupIndexLow
		decf lookupIndexHigh

wrapIndexToFirstEntryIfPastEndOfTable:
		movlw low(LOOKUP_LENGTH)
		xorwf lookupIndexLow, W
		btfss STATUS, Z
		goto nextState

		movlw high(LOOKUP_LENGTH)
		xorwf lookupIndexHigh, W
		btfss STATUS, Z
		goto nextState

		clrf lookupIndexHigh
		clrf lookupIndexLow

nextState:
		movf sunriseSunsetNextState, W
		movwf sunriseSunsetState
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_LOADLOOKUPS3
		call mergeLookupEntryReferenceMinute
		movwf lookupEntryReferenceMinuteLow

		setSunriseSunsetState SUN_STATE_INTERPOLATE_REFERENCE
		returnFromSunriseSunsetState


mergeLookupEntryReferenceMinute:
	.knownBank sunriseSunsetState
	.setBankFor lookupEntryReferenceMinuteLow
	rlf lookupEntryReferenceMinuteLow ; C is undefined - doesn't matter
	rlf lookupEntryReferenceMinuteLow ; C is now 0 as only 6 lower bits are set
	rrf lookupEntryReferenceMinuteHigh
	rrf lookupEntryReferenceMinuteLow
	rrf lookupEntryReferenceMinuteHigh
	rrf lookupEntryReferenceMinuteLow, W ; The undefined C is now shifted away
	return

	end
