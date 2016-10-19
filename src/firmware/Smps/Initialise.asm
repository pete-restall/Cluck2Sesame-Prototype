	#include "p16f685.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"
	#include "Smps.inc"

	radix decimal

	extern INITIALISE_AFTER_SMPS
	extern enableSmpsCount

Smps code
	global initialiseSmps

initialiseSmps:
	banksel enableSmpsCount
	movlw 1
	movwf enableSmpsCount

setPortModes:
	banksel ANSELH
	bcf ANSELH, SMPS_EN_PIN_ANSH

clearDigitalOutputs:
	banksel SMPS_PORT
	bcf SMPS_PORT, SMPS_EN_PIN

setPortDirections:
	banksel SMPS_TRIS
	bsf SMPS_TRIS, SMPS_EN_PIN_TRIS

	tcall INITIALISE_AFTER_SMPS

	end
