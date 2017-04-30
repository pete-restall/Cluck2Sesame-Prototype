	#define __CLUCK2SESAME_SUNRISESUNSET_REGISTERLOADANDANDSTORE_ASM

	#include "Platform.inc"
	#include "Arithmetic32.inc"
	#include "SunriseSunset.inc"

	radix decimal

	.externalVariableIn CLOCK, dayOfYearHigh
	.externalVariableIn CLOCK, dayOfYearLow

SunriseSunset code
	global loadAccumulatorIntoA
	global loadAccumulatorIntoB
	global loadWIntoB
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
	global loadLookupReferenceDeltaMinutesIntoUpperB
	global loadLookupReferenceMinuteIntoB
	global storeAccumulatorFromA
	global storeLookupIndexFromA
	global storeLookupReferenceDeltaMinutesFromA

loadAccumulatorIntoA:
	.unknownBank
	setupIndf accumulator

loadIntoA:
	.unknownBank
	loadFromIndf32Into RAA
	return

loadAccumulatorIntoB:
	.unknownBank
	setupIndf accumulator

loadIntoB:
	.unknownBank
	loadFromIndf32Into RBA
	return

loadDayOfYearIntoA:
	.safelySetBankFor dayOfYearHigh
	movf dayOfYearHigh, W
	.setBankFor RAA
	clrf RAA
	clrf RAB
	movwf RAC
	.setBankFor dayOfYearLow
	movf dayOfYearLow, W
	.setBankFor RAD
	movwf RAD
	return

loadFirstLookupReferenceMinuteIntoB:
loadLookupReferenceMinuteIntoB:
	.safelySetBankFor lookupReferenceMinuteHigh
	movf lookupReferenceMinuteHigh, W
	.setBankFor RBC
	movwf RBC
	.setBankFor lookupReferenceMinuteLow
	movf lookupReferenceMinuteLow, W

loadWIntoRBDAndSignExtendUpperWord:
	.safelySetBankFor RBD
	movwf RBD
	movlw 0x00
	btfsc RBC, 7
	movlw 0xff
	movwf RBA
	movwf RBB
	return

loadFirstLookupDeltaMinutesNorthIntoB:
	.safelySetBankFor lookupReferenceDeltaMinutesNorth
	movf lookupReferenceDeltaMinutesNorth, W

loadWIntoB:
	.safelySetBankFor RBD
	movwf RBD
	clrw
	btfsc RBD, 7
	movlw 0xff
	movwf RBC
	movwf RBB
	movwf RBA
	return

loadFirstLookupDeltaMinutesSouthIntoB:
	.safelySetBankFor lookupReferenceDeltaMinutesSouth
	movf lookupReferenceDeltaMinutesSouth, W
	goto loadWIntoB

loadSecondLookupReferenceMinuteIntoA:
	.safelySetBankFor lookupEntry
	movf lookupEntryReferenceMinuteHigh, W
	.setBankFor RAA
	clrf RAA
	clrf RAB
	movwf RAC
	.setBankFor lookupEntry
	movf lookupEntryReferenceMinuteLow, W
	.setBankFor RAD
	movwf RAD
	return

loadSecondLookupDeltaMinutesNorthIntoA:
	.safelySetBankFor lookupEntryReferenceDeltaMinutesNorth
	movf lookupEntryReferenceDeltaMinutesNorth, W

loadWIntoA:
	.safelySetBankFor RAD
	movwf RAD
	clrw
	btfsc RAD, 7
	movlw 0xff
	movwf RAC
	movwf RAB
	movwf RAA
	return

loadSecondLookupDeltaMinutesSouthIntoA:
	.safelySetBankFor lookupEntryReferenceDeltaMinutesSouth
	movf lookupEntryReferenceDeltaMinutesSouth, W
	goto loadWIntoA

loadLookupIndexRemainderIntoUpperB:
	.safelySetBankFor lookupIndexRemainderHigh
	movf lookupIndexRemainderHigh, W
	.setBankFor RBA
	movwf RBA
	.setBankFor lookupIndexRemainderLow
	movf lookupIndexRemainderLow, W
	.setBankFor RBB
	movwf RBB
	return

loadLookupStepIntoLowerB:
	.safelySetBankFor RBC
	clrf RBC
	movlw LOOKUP_STEP
	movwf RBD
	return

loadLookupReferenceDeltaMinutesIntoB:
	.safelySetBankFor lookupReferenceDeltaMinutesHigh
	movf lookupReferenceDeltaMinutesHigh, W
	.setBankFor RBC
	movwf RBC
	.setBankFor lookupReferenceDeltaMinutesLow
	movf lookupReferenceDeltaMinutesLow, W
	goto loadWIntoRBDAndSignExtendUpperWord

loadLookupReferenceDeltaMinutesIntoUpperB:
	.safelySetBankFor lookupReferenceDeltaMinutesHigh
	movf lookupReferenceDeltaMinutesHigh, W
	.setBankFor RBA
	movwf RBA
	.setBankFor lookupReferenceDeltaMinutesLow
	movf lookupReferenceDeltaMinutesLow, W
	.setBankFor RBB
	movwf RBB
	return

storeAccumulatorFromA:
	.unknownBank
	setupIndf accumulator

storeFromA:
	.unknownBank
	storeIntoIndf32From RAA
	return

storeLookupIndexFromA:
	.unknownBank
	setupIndf lookupIndexRemainder
	goto storeFromA

storeLookupReferenceDeltaMinutesFromA:
	.safelySetBankFor RAC
	movf RAC, W
	.setBankFor lookupReferenceDeltaMinutesHigh
	movwf lookupReferenceDeltaMinutesHigh
	.setBankFor RAD
	movf RAD, W
	.setBankFor lookupReferenceDeltaMinutesLow
	movwf lookupReferenceDeltaMinutesLow
	return

	end
