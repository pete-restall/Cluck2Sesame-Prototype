	#include "p16f685.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"
	#include "Smps.inc"

	radix decimal

	extern INITIALISE_AFTER_SMPS

Smps code
	global initialiseSmps

initialiseSmps:
flagSmpsVddAsEnabledAndStableAtBoot:
	banksel enableSmpsCount
	movlw 1
	movwf enableSmpsCount

	banksel smpsFlags
	movlw (1 << SMPS_FLAG_VDD_STABLE)
	movwf smpsFlags

setPortModes:
	banksel ANSELH
	bcf ANSELH, SMPS_EN_PIN_ANSH ; TODO: I RECKON ANSEL NEEDS TO BE SET BECAUSE BATTERY / PIC VDD MAY VARY SOMEWHAT

clearDigitalOutputs:
	banksel SMPS_PORT
	bcf SMPS_PORT, SMPS_EN_PIN

setPortDirections:
	banksel SMPS_TRIS
	bsf SMPS_TRIS, SMPS_EN_PIN_TRIS

	tcall INITIALISE_AFTER_SMPS

	end
