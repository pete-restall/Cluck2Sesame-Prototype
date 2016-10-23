	#include "p16f685.inc"
	#include "Smps.inc"

	radix decimal

	udata
	global enableSmpsCount

enableSmpsCount res 1

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
	return

isSmpsEnabled:
	; TODO: THE +3.3V LINE IS ONLY AVAILABLE > 1ms AFTER SMPS_EN IS ASSERTED
	; USE TIMER0 (1:256 PRESCALE) FOR THIS, SO FOUR TICKS SHOULD BE > 1ms,
	; ALONG WITH AN updateSmps() POLL THAT CHECKS THE TIMER VALUES TO SET A
	; FLAG.
	return

	end