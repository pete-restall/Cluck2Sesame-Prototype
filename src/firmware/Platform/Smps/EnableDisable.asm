	#define __CLUCK2SESAME_PLATFORM_SMPS_ENABLEDISABLE_ASM

	#include "Platform.inc"
	#include "Smps.inc"

	radix decimal

SmpsRam udata
	global enableSmpsCount
	global smpsFlags

enableSmpsCount res 1
smpsFlags res 1

Smps code
	global enableSmps
	global disableSmps
	global isSmpsEnabled

enableSmps:
	.safelySetBankFor SMPS_TRIS
	bsf SMPS_TRIS, SMPS_EN_PIN_TRIS

	.setBankFor enableSmpsCount
	incf enableSmpsCount
	return

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
