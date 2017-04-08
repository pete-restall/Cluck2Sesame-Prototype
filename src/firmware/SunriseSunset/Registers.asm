	#include "Platform.inc"

	radix decimal

SunriseSunsetRam udata
	global latitudeOffset
	global longitudeOffset
	global sunriseHourBcd
	global sunriseMinuteBcd
	global sunsetHourBcd
	global sunsetMinuteBcd

	global sunriseSunsetState
	global sunriseSunsetNextState
	global sunriseSunsetStoreState

	global lookupIndexRemainder
	global lookupIndexRemainderHigh
	global lookupIndexRemainderLow
	global lookupIndex
	global lookupIndexHigh
	global lookupIndexLow

	global lookupReferenceMinute
	global lookupReferenceMinuteHigh
	global lookupReferenceMinuteLow
	global lookupReferenceDeltaMinutesHigh
	global lookupReferenceDeltaMinutesNorth
	global lookupReferenceDeltaMinutesLow
	global lookupReferenceDeltaMinutesSouth

	global lookupEntry
	global lookupEntryReferenceMinuteHigh
	global lookupEntryReferenceDeltaMinutesNorth
	global lookupEntryReferenceMinuteLow
	global lookupEntryReferenceDeltaMinutesSouth

	global accumulator
	global accumulatorUpper
	global accumulatorUpperHigh
	global accumulatorUpperLow
	global accumulatorLower
	global accumulatorLowerHigh
	global accumulatorLowerLow

latitudeOffset res 1
longitudeOffset res 1
sunriseHourBcd res 1
sunriseMinuteBcd res 1
sunsetHourBcd res 1
sunsetMinuteBcd res 1

sunriseSunsetState res 1
sunriseSunsetNextState res 1
sunriseSunsetStoreState res 1

lookupIndexRemainder:
lookupIndexRemainderHigh res 1
lookupIndexRemainderLow res 1
lookupIndex:
lookupIndexHigh res 1
lookupIndexLow res 1

lookupReferenceMinute:
lookupReferenceMinuteHigh res 1
lookupReferenceMinuteLow res 1
lookupReferenceDeltaMinutesHigh:
lookupReferenceDeltaMinutesNorth res 1
lookupReferenceDeltaMinutesLow:
lookupReferenceDeltaMinutesSouth res 1

lookupEntry:
lookupEntryReferenceMinuteHigh res 1
lookupEntryReferenceDeltaMinutesNorth res 1
lookupEntryReferenceMinuteLow res 1
lookupEntryReferenceDeltaMinutesSouth res 1

accumulator:
accumulatorUpper:
accumulatorUpperHigh res 1
accumulatorUpperLow res 1
accumulatorLower:
accumulatorLowerHigh res 1
accumulatorLowerLow res 1

	end
