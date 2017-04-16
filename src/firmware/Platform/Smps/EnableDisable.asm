	#include "Platform.inc"
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
	return

disableSmpsHighPowerMode:
	.safelySetBankFor enableSmpsHighPowerModeCount
	decfsz enableSmpsHighPowerModeCount
	goto disableSmps
	bsf smpsFlags, SMPS_FLAG_HIGHPOWERMODE

disableSmps:
	.safelySetBankFor enableSmpsCount
	decfsz enableSmpsCount
	return

	.setBankFor SMPS_TRIS
	bcf SMPS_TRIS, SMPS_EN_PIN_TRIS

	.setBankFor SMPS_PORT
	bcf SMPS_PORT, SMPS_EN_PIN
	return

isSmpsEnabled:
	movlw 1
	; TODO: THE +3.3V LINE IS ONLY AVAILABLE > 1ms AFTER SMPS_EN IS ASSERTED.
	; USE THE elapsedSinceTimer0() MACRO FOR THIS, SO EIGHT TICKS SHOULD
	; BE > 1ms, ALONG WITH A pollSmps() THAT CHECKS THE TIMER VALUES
	; TO SET smpsFlags.SMPS_FLAG_VDD_STABLE.  THE pollSmps() ALSO NEEDS TO
	; ENSURE THAT CLOCK SWITCHING AND SLEEP ARE DISABLED UNTIL THE SMPS HAS
	; BEEN VERIFIED AS STABLE.
	return

	end
