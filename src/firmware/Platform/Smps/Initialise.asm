	#include "Platform.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"
	#include "Smps.inc"

	radix decimal

	extern INITIALISE_AFTER_SMPS

Smps code
	global initialiseSmps

initialiseSmps:
flagSmpsVddAsEnabledAndStableAtBoot:
	.safelySetBankFor enableSmpsCount
	movlw 1
	movwf enableSmpsCount
	clrf enableSmpsHighPowerModeCount

	.setBankFor smpsFlags
	movlw (1 << SMPS_FLAG_VDDSTABLE)
	movwf smpsFlags

setPortModeToAnalogue:
	.setBankFor ANSELH
	bsf ANSELH, SMPS_EN_PIN_ANSH

clearDigitalOutputs:
	.setBankFor SMPS_PORT
	bcf SMPS_PORT, SMPS_EN_PIN

setPortDirections:
	.setBankFor SMPS_TRIS
	bsf SMPS_TRIS, SMPS_EN_PIN_TRIS

	tcall INITIALISE_AFTER_SMPS

	end
