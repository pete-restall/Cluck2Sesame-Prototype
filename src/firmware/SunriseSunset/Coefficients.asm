	#define __CLUCK2SESAME_SUNRISESUNSET_COEFFICIENTS_ASM

	#include "Mcu.inc"
	#include "TableJumps.inc"
	#include "SunriseSunset.inc"

	radix decimal

loadExtendedCoefficientsIntoW macro a, b, c
	movlw ((a & 0x03) << 0) | ((b & 0x03) << 2) | ((c & 0x03) << 4)
	endm

SunriseSunset code
	global loadNextCoefficient
	global loadSunriseReferenceExtendedCoefficients
	global loadSunriseReferenceNorthExtendedCoefficients
	global loadSunriseReferenceSouthExtendedCoefficients
	global loadSunsetReferenceExtendedCoefficients
	global loadSunsetReferenceNorthExtendedCoefficients
	global loadSunsetReferenceSouthExtendedCoefficients

loadNextCoefficient:
	call loadCoefficientIntoW
	banksel coefficient
	movwf coefficientHigh
	incf coefficientIndex

	call loadCoefficientIntoW
	banksel coefficient
	movwf coefficientLow
	incf coefficientIndex
	return

loadSunriseReferenceExtendedCoefficients:
	loadExtendedCoefficientsIntoW 0, 2, 0

storeExtendedCoefficientsFromW:
	banksel extendedCoefficients
	movwf extendedCoefficients
	return

loadSunriseReferenceNorthExtendedCoefficients:
	loadExtendedCoefficientsIntoW 0, 0, 0
	goto storeExtendedCoefficientsFromW

loadSunriseReferenceSouthExtendedCoefficients:
	loadExtendedCoefficientsIntoW 0, 1, 0
	goto storeExtendedCoefficientsFromW

loadSunsetReferenceExtendedCoefficients:
	loadExtendedCoefficientsIntoW 0, 1, 0
	goto storeExtendedCoefficientsFromW

loadSunsetReferenceNorthExtendedCoefficients:
	loadExtendedCoefficientsIntoW 0, 0, 3
	goto storeExtendedCoefficientsFromW

loadSunsetReferenceSouthExtendedCoefficients:
	loadExtendedCoefficientsIntoW 2, 0, 2
	goto storeExtendedCoefficientsFromW

loadCoefficientIntoW:
	tableDefinitionToJumpWith coefficientIndex
sunriseReference:
	retlw high(12776)
	retlw low(12776)

	retlw high(630)
	retlw low(630)

	retlw high(18869)
	retlw low(18869)

	retlw high(8430)
	retlw low(8430)

	retlw high(13361)
	retlw low(13361)

	retlw high(-7993)
	retlw low(-7993)

	retlw high(214)
	retlw low(214)

	retlw high(30005)
	retlw low(30005)

	retlw high(10688)
	retlw low(10688)

	retlw high(3551)
	retlw low(3551)

sunriseReferenceNorth:
	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

sunriseReferenceSouth:
	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

sunsetReference:
	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

sunsetReferenceNorth:
	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

sunsetReferenceSouth:
	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	retlw high(0x00)
	retlw low(0x00)

	end
