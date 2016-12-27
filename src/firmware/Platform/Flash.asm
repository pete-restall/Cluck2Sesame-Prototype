	#include "Mcu.inc"

	radix decimal

Flash code
	global readFlashWordAsPairOfSevenBitBytes
	global readFlashWord

readFlashWordAsPairOfSevenBitBytes:
	call readFlashWord
	banksel EEDAT
	rlf EEDAT, W
	rlf EEDATH, W
	bcf EEDAT, 7
	return

readFlashWord:
	banksel EECON1
	bsf EECON1, EEPGD
	bsf EECON1, RD
	nop
	nop
	return

	end
