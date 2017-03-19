	#ifndef __CLUCK2SESAME_SUNRISESUNSET_SUNRISESUNSET_INC
	#define __CLUCK2SESAME_SUNRISESUNSET_SUNRISESUNSET_INC
	#include "../SunriseSunset.inc"

	radix decimal

LOOKUP_STEP equ 6
LOOKUP_LENGTH equ 366 / LOOKUP_STEP
LOOKUP_LATITUDE_DELTA_DEGREES equ 5
LOOKUP_LATITUDE_DELTA equ LOOKUP_LATITUDE_DELTA_DEGREES * 10

	extern sunriseLookupTable
	extern sunsetLookupTable

	extern lookupIndex
	extern lookupIndexHigh
	extern lookupIndexLow
	extern lookupIndexRemainder
	extern lookupIndexRemainderHigh
	extern lookupIndexRemainderLow

	extern lookupReferenceMinute
	extern lookupReferenceMinuteHigh
	extern lookupReferenceMinuteLow
	extern lookupReferenceDeltaMinutesHigh
	extern lookupReferenceDeltaMinutesNorth
	extern lookupReferenceDeltaMinutesLow
	extern lookupReferenceDeltaMinutesSouth

	extern lookupEntry
	extern lookupEntryReferenceMinuteHigh
	extern lookupEntryReferenceDeltaMinutesNorth
	extern lookupEntryReferenceMinuteLow
	extern lookupEntryReferenceDeltaMinutesSouth

	extern accumulator
	extern accumulatorUpper
	extern accumulatorUpperHigh
	extern accumulatorUpperLow
	extern accumulatorLower
	extern accumulatorLowerHigh
	extern accumulatorLowerLow

	#ifndef __CLUCK2SESAME_SUNRISESUNSET_REGISTERLOADANDANDSTORE_ASM
	extern loadAccumulatorIntoA
	extern loadAccumulatorIntoB
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
