	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "TailCalls.inc"
	#include "Timer0.inc"
	#include "PowerManagement.inc"
	#include "PollChain.inc"
	#include "ShiftRegister.inc"
	#include "Smps.inc"

	radix decimal

	extern POLL_AFTER_SMPS

NUMBER_OF_TICKS_1MS equ 8

SMPS_SHIFTREGISTER_HIGHPOWER equ 7

Smps code
	global pollForWork
	global pollSmps

pollForWork:
pollSmps:
	.safelySetBankFor smpsFlags
	btfss smpsFlags, SMPS_FLAG_WAITFORSTABLEVDD
	goto tryTogglingHighPowerMode

waitForVddToStabilise:
	elapsedSinceTimer0 smpsEnabledTimestamp
	sublw NUMBER_OF_TICKS_1MS - 1
	btfsc STATUS, C
	goto vddNotStableYet

vddHasStabilised:
	.setBankFor smpsFlags
	bcf smpsFlags, SMPS_FLAG_WAITFORSTABLEVDD
	bsf smpsFlags, SMPS_FLAG_VDDSTABLE

	.setBankFor PIC_VDD_TRIS
	bsf PIC_VDD_TRIS, PIC_VDD_SMPS_EN_PIN_TRIS
	fcall allowSlowClock

vddNotStableYet:
	fcall preventSleep

tryTogglingHighPowerMode:
	.safelySetBankFor smpsFlags
	btfss smpsFlags, SMPS_FLAG_HIGHPOWERMODE
	goto pollNextInChain

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
