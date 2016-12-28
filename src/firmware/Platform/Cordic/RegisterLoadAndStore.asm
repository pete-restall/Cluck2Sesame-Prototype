	#define __CLUCK2SESAME_PLATFORM_CORDIC_REGISTERLOADANDSTORE_ASM

	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "TailCalls.inc"
	#include "GeneralPurposeRegisters.inc"
	#include "Arithmetic32.inc"
	#include "Cordic.inc"

	radix decimal

Cordic code
	global loadCordicZIntoB
	global loadCordicArgumentIntoA
	global storeCordicErrorFromA

loadCordicZIntoB:
	loadFrom32 cordicZ, RBA
	return

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

storeCordicErrorFromA:
	storeInto32 RAA, cordicError
	return

	end
