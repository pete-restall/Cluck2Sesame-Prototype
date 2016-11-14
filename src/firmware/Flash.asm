	#include "p16f685.inc"

	radix decimal

Flash code
	global readFlashWordAsPairOfSevenBitBytes

readFlashWordAsPairOfSevenBitBytes:
	banksel EECON1
	bsf EECON1, EEPGD
	bsf EECON1, RD
	nop
	nop

	banksel EEDAT
	rlf EEDAT, W
	rlf EEDATH, W
	bcf EEDAT, 7
	return

	end
