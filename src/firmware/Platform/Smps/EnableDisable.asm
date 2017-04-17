	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "TailCalls.inc"
	#include "Timer0.inc"
	#include "PowerManagement.inc"
	#include "Smps.inc"

	radix decimal

Smps code
	global enableSmps
	global enableSmpsHighPowerMode
	global disableSmps
	global disableSmpsHighPowerMode
	global isSmpsEnabled

enableSmpsHighPowerMode:
	.safelySetBankFor enableSmpsHighPowerModeCount
	incf enableSmpsHighPowerModeCount
	decfsz enableSmpsHighPowerModeCount, W
	goto enableSmps
	bsf smpsFlags, SMPS_FLAG_HIGHPOWERMODE

enableSmps:
	.safelySetBankFor SMPS_TRIS
	bsf SMPS_TRIS, SMPS_EN_PIN_TRIS

	.setBankFor enableSmpsCount
	incf enableSmpsCount
	decfsz enableSmpsCount, W
	return

firstTimeSmpsHasBeenEnabled:
	bsf smpsFlags, SMPS_FLAG_WAITFORSTABLEVDD
	storeTimer0 smpsEnabledTimestamp
	fcall ensureFastClock
	tcall preventSleep

disableSmpsHighPowerMode:
	.safelySetBankFor enableSmpsHighPowerModeCount
	decfsz enableSmpsHighPowerModeCount
	goto disableSmps
	bsf smpsFlags, SMPS_FLAG_HIGHPOWERMODE

disableSmps:
	.safelySetBankFor enableSmpsCount
	decfsz enableSmpsCount
	return

	bcf smpsFlags, SMPS_FLAG_VDDSTABLE
	bcf smpsFlags, SMPS_FLAG_WAITFORSTABLEVDD

	.setBankFor SMPS_TRIS
	bcf SMPS_TRIS, SMPS_EN_PIN_TRIS

	.setBankFor SMPS_PORT
	bcf SMPS_PORT, SMPS_EN_PIN

	.setBankFor PIC_VDD_PORT
	bcf PIC_VDD_PORT, PIC_VDD_SMPS_EN_PIN

	.setBankFor PIC_VDD_TRIS
	bcf PIC_VDD_TRIS, PIC_VDD_SMPS_EN_PIN_TRIS
	return

isSmpsEnabled:
	.safelySetBankFor smpsFlags
	btfss smpsFlags, SMPS_FLAG_VDDSTABLE
	retlw 0
	retlw 1

	end
