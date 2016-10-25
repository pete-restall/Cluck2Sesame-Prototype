	#define __CLUCK2SESAME_SMPS_ENABLEDISABLE_ASM

	#include "p16f685.inc"
	#include "Smps.inc"

	radix decimal

	udata
	global enableSmpsCount
	global smpsFlags

enableSmpsCount res 1
smpsFlags res 1

Smps code
	global enableSmps
	global disableSmps
	global isSmpsEnabled

enableSmps:
	banksel SMPS_TRIS
	bsf SMPS_TRIS, SMPS_EN_PIN_TRIS

	banksel enableSmpsCount
	incf enableSmpsCount
	return

disableSmps:
	banksel enableSmpsCount
	decfsz enableSmpsCount
	return

	banksel SMPS_TRIS
	bcf SMPS_TRIS, SMPS_EN_PIN_TRIS

	banksel SMPS_PORT
	bcf SMPS_PORT, SMPS_EN_PIN
	return

isSmpsEnabled:
	movlw 1
	; TODO: THE +3.3V LINE IS ONLY AVAILABLE > 1ms AFTER SMPS_EN IS ASSERTED.
	; USE THE elapsedSinceTimer0() MACRO FOR THIS, SO EIGHT TICKS SHOULD
	; BE > 1ms, ALONG WITH AN updateSmps() POLL THAT CHECKS THE TIMER VALUES
	; TO SET smpsFlags.SMPS_FLAG_VDD_STABLE.
	return

	end
