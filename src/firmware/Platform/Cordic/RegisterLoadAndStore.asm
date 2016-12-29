	#define __CLUCK2SESAME_PLATFORM_CORDIC_REGISTERLOADANDSTORE_ASM

	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "TailCalls.inc"
	#include "GeneralPurposeRegisters.inc"
	#include "Arithmetic32.inc"
	#include "Cordic.inc"

	radix decimal

Cordic code
	global loadCordicArgumentIntoA
	global loadCordicXIntoA
	global loadCordicXIntoCordicW
	global loadCordicYIntoA
	global loadCordicYIntoCordicW
	global loadCordicZIntoA
	global loadCordicZIntoB
	global loadCordicWIntoB

	global storeAIntoCordicX
	global storeAIntoCordicY
	global storeAIntoCordicZ
	global storeSaturatedAIntoCordicResultQ15

loadCordicArgumentIntoA:
	banksel cordicArgumentHigh
	movf cordicArgumentHigh, W
	banksel RAC
	movwf RAC

	banksel cordicArgumentLow
	movf cordicArgumentLow, W
	banksel RAD
	movwf RAD

	tcall signExtendToUpperWordA32

loadCordicXIntoA:
	setupIndf cordicX

loadIntoA:
	loadFromIndf32Into RAA
	return

loadCordicXIntoCordicW:
	setupIndf cordicX

loadIntoCordicW:
	loadFromIndf32Into cordicW
	return

loadCordicYIntoA:
	setupIndf cordicY
	goto loadIntoA

loadCordicYIntoCordicW:
	setupIndf cordicY
	goto loadIntoCordicW

loadCordicZIntoA:
	setupIndf cordicZ
	goto loadIntoA

loadCordicZIntoB:
	setupIndf cordicZ

loadIntoB:
	loadFromIndf32Into RBA
	return

loadCordicWIntoB:
	setupIndf cordicW
	goto loadIntoB

storeAIntoCordicX:
	setupIndf cordicX

storeFromA:
	storeIntoIndf32From RAA
	return

storeAIntoCordicY:
	setupIndf cordicY
	goto storeFromA

storeAIntoCordicZ:
	setupIndf cordicZ
	goto storeFromA

storeSaturatedAIntoCordicResultQ15:
	banksel RAA
	btfsc RAA, 7
	goto storeNegativeA

storePositiveA:
checkIfAnyBits31To15AreSet:
	movf RAA
	btfsc STATUS, Z
	movf RAB
	btfsc STATUS, Z
	btfsc RAC, 7
	goto storeSaturatedPositiveIntoCordicResult

storeLowerWordOfAIntoCordicResult:
	movf RAC, W
	banksel cordicResult
	movwf cordicResultHigh
	movf RAD, W
	banksel cordicResult
	movwf cordicResultLow
	return

storeSaturatedPositiveIntoCordicResult:
	banksel cordicResult
	movlw 0x7f
	movwf cordicResultHigh
	movlw 0xff
	movwf cordicResultLow
	return

storeNegativeA:
	; TODO: NEED TO CHECK FOR NEGATIVE SATURATION...
	goto storeLowerWordOfAIntoCordicResult
	return

	end
