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

	end
