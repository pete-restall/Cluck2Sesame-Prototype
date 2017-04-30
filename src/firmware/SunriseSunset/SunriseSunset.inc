	#ifndef __CLUCK2SESAME_SUNRISESUNSET_SUNRISESUNSET_INC
	#define __CLUCK2SESAME_SUNRISESUNSET_SUNRISESUNSET_INC
	#include "Platform.inc"
	#include "../SunriseSunset.inc"

	radix decimal

	.module SUNRISESUNSET

LOOKUP_STEP equ 6
LOOKUP_LENGTH equ 366 / LOOKUP_STEP
LOOKUP_LATITUDE_DELTA_DEGREES equ 5
LOOKUP_LATITUDE_DELTA equ LOOKUP_LATITUDE_DELTA_DEGREES * 10

	extern sunriseLookupTable
	extern sunsetLookupTable

	.externalVariable adjustmentMinutes

	.externalVariable lookupIndex
	.externalVariable lookupIndexHigh
	.externalVariable lookupIndexLow
	.externalVariable lookupIndexRemainder
	.externalVariable lookupIndexRemainderHigh
	.externalVariable lookupIndexRemainderLow

	.externalVariable lookupReferenceMinute
	.externalVariable lookupReferenceMinuteHigh
	.externalVariable lookupReferenceMinuteLow
	.externalVariable lookupReferenceDeltaMinutesHigh
	.externalVariable lookupReferenceDeltaMinutesNorth
	.externalVariable lookupReferenceDeltaMinutesLow
	.externalVariable lookupReferenceDeltaMinutesSouth

	.externalVariable lookupEntry
	.externalVariable lookupEntryReferenceMinuteHigh
	.externalVariable lookupEntryReferenceDeltaMinutesNorth
	.externalVariable lookupEntryReferenceMinuteLow
	.externalVariable lookupEntryReferenceDeltaMinutesSouth

	.externalVariable accumulator
	.externalVariable accumulatorUpper
	.externalVariable accumulatorUpperHigh
	.externalVariable accumulatorUpperLow
	.externalVariable accumulatorLower
	.externalVariable accumulatorLowerHigh
	.externalVariable accumulatorLowerLow

	#ifndef __CLUCK2SESAME_SUNRISESUNSET_REGISTERLOADANDANDSTORE_ASM
	extern loadAccumulatorIntoA
	extern loadAccumulatorIntoB
	extern loadWIntoB
	extern loadDayOfYearIntoA
	extern loadFirstLookupReferenceMinuteIntoB
	extern loadFirstLookupDeltaMinutesNorthIntoB
	extern loadFirstLookupDeltaMinutesSouthIntoB
	extern loadSecondLookupReferenceMinuteIntoA
	extern loadSecondLookupDeltaMinutesNorthIntoA
	extern loadSecondLookupDeltaMinutesSouthIntoA
	extern loadLookupIndexRemainderIntoUpperB
	extern loadLookupStepIntoLowerB
	extern loadLookupReferenceDeltaMinutesIntoB
	extern loadLookupReferenceDeltaMinutesIntoUpperB
	extern loadLookupReferenceMinuteIntoB
	extern storeAccumulatorFromA
	extern storeLookupIndexFromA
	extern storeLookupReferenceDeltaMinutesFromA
	#endif

	#ifndef __CLUCK2SESAME_SUNRISESUNSET_LOADLOOKUPTABLEENTRYFROMFLASH_ASM
	extern loadLookupTableEntryFromFlash
	#endif

	extern muls16x16

	#endif
