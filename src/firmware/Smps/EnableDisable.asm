	#include "p16f685.inc"
	#include "Smps.inc"

	radix decimal

	udata
	global enableSmpsCount

enableSmpsCount res 1

Smps code
	global enableSmps
	global disableSmps

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

	end
