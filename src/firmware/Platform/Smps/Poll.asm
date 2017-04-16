	#include "Platform.inc"
	#include "TailCalls.inc"
	#include "PollChain.inc"
	#include "ShiftRegister.inc"
	#include "Smps.inc"

	radix decimal

	extern POLL_AFTER_SMPS

SMPS_SHIFTREGISTER_HIGHPOWER equ 7

Smps code
	global pollForWork
	global pollSmps

pollForWork:
pollSmps:
	.safelySetBankFor smpsFlags
	btfss smpsFlags, SMPS_FLAG_HIGHPOWERMODE
	goto pollNextInChain

tryTogglingHighPowerMode:
	fcall isShiftRegisterEnabled
	xorlw 0
	btfsc STATUS, Z
	goto pollNextInChain

	.setBankFor smpsFlags
	bcf smpsFlags, SMPS_FLAG_HIGHPOWERMODE
	movf enableSmpsHighPowerModeCount

	.setBankFor shiftRegisterBuffer
	bcf shiftRegisterBuffer, SMPS_SHIFTREGISTER_HIGHPOWER
	btfss STATUS, Z
	bsf shiftRegisterBuffer, SMPS_SHIFTREGISTER_HIGHPOWER
	fcall shiftOut

pollNextInChain:
	tcall POLL_AFTER_SMPS

	end
