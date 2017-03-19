	#define __CLUCK2SESAME_SUNRISESUNSET_REGISTERLOADANDANDSTORE_ASM

	#include "Mcu.inc"
	#include "Arithmetic32.inc"
	#include "SunriseSunset.inc"

	radix decimal

	extern dayOfYearHigh
	extern dayOfYearLow

SunriseSunset code
	global loadAccumulatorIntoA
	global loadAccumulatorIntoB
	global loadDayOfYearIntoA
	global loadFirstLookupReferenceMinuteIntoB
	global loadFirstLookupDeltaMinutesNorthIntoB
	global loadFirstLookupDeltaMinutesSouthIntoB
	global loadSecondLookupReferenceMinuteIntoA
	global loadSecondLookupDeltaMinutesNorthIntoA
	global loadSecondLookupDeltaMinutesSouthIntoA
	global loadLookupIndexRemainderIntoUpperB
	global loadLookupStepIntoLowerB
	global loadLookupReferenceDeltaMinutesIntoB
	global loadLookupReferenceMinuteIntoB
	global storeAccumulatorFromA
	global storeLookupIndexFromA
	global storeLookupReferenceDeltaMinutesFromA

loadAccumulatorIntoA:
	setupIndf accumulator

loadIntoA:
	loadFromIndf32Into RAA
	return

loadAccumulatorIntoB:
	setupIndf accumulator

loadIntoB:
	loadFromIndf32Into RBA
	return

loadDayOfYearIntoA:
	banksel dayOfYearHigh
	movf dayOfYearHigh, W
	banksel RAA
	clrf RAA
	clrf RAB
	movwf RAC
	banksel dayOfYearLow
	movf dayOfYearLow, W
	banksel RAD
	movwf RAD
	return

loadFirstLookupReferenceMinuteIntoB:
loadLookupReferenceMinuteIntoB:
	banksel lookupReferenceMinuteHigh
	movf lookupReferenceMinuteHigh, W
	banksel RBC
	movwf RBC
	banksel lookupReferenceMinuteLow
	movf lookupReferenceMinuteLow, W

loadWIntoRBDAndSignExtendUpperWord:
	banksel RBD
	movwf RBD
	movlw 0x00
	btfsc RBC, 7
	movlw 0xff
	movwf RBA
	movwf RBB
	return

loadFirstLookupDeltaMinutesNorthIntoB:
	banksel lookupReferenceDeltaMinutesNorth
	movf lookupReferenceDeltaMinutesNorth, W

loadWIntoB:
	banksel RBD
	movwf RBD
	rlf RBD, W
	clrw
	btfsc STATUS, C
	movlw 0xff
	movwf RBC
	movwf RBB
	movwf RBA
	return

loadFirstLookupDeltaMinutesSouthIntoB:
	banksel lookupReferenceDeltaMinutesSouth
	movf lookupReferenceDeltaMinutesSouth, W
	goto loadWIntoB

loadSecondLookupReferenceMinuteIntoA:
	banksel lookupEntry
	movf lookupEntryReferenceMinuteHigh, W
	banksel RAA
	clrf RAA
	clrf RAB
	movwf RAC
	banksel lookupEntry
	movf lookupEntryReferenceMinuteLow, W
	banksel RAD
	movwf RAD
	return

loadSecondLookupDeltaMinutesNorthIntoA:
	banksel lookupEntryReferenceDeltaMinutesNorth
	movf lookupEntryReferenceDeltaMinutesNorth, W

loadWIntoA:
	banksel RAD
	movwf RAD
	rlf RAD, W
	clrw
	btfsc STATUS, C
	movlw 0xff
	movwf RAC
	movwf RAB
	movwf RAA
	return

loadSecondLookupDeltaMinutesSouthIntoA:
	banksel lookupEntryReferenceDeltaMinutesSouth
	movf lookupEntryReferenceDeltaMinutesSouth, W
	goto loadWIntoA

loadLookupIndexRemainderIntoUpperB:
	banksel lookupIndexRemainderHigh
	movf lookupIndexRemainderHigh, W
	banksel RBA
	movwf RBA
	banksel lookupIndexRemainderLow
	movf lookupIndexRemainderLow, W
	banksel RBB
	movwf RBB
	return

loadLookupStepIntoLowerB:
	banksel RBC
	clrf RBC
	movlw LOOKUP_STEP
	movwf RBD
	return

loadLookupReferenceDeltaMinutesIntoB:
	banksel lookupReferenceDeltaMinutesHigh
	movf lookupReferenceDeltaMinutesHigh, W
	banksel RBC
	movwf RBC
	banksel lookupReferenceDeltaMinutesLow
	movf lookupReferenceDeltaMinutesLow, W
	goto loadWIntoRBDAndSignExtendUpperWord

storeAccumulatorFromA:
	setupIndf accumulator

storeFromA:
	storeIntoIndf32From RAA
	return

storeLookupIndexFromA:
	setupIndf lookupIndexRemainder
	goto storeFromA

storeLookupReferenceDeltaMinutesFromA:
	banksel RAC
	movf RAC, W
	banksel lookupReferenceDeltaMinutesHigh
	movwf lookupReferenceDeltaMinutesHigh
	banksel RAD
	movf RAD, W
	banksel lookupReferenceDeltaMinutesLow
	movwf lookupReferenceDeltaMinutesLow
	return

	end
