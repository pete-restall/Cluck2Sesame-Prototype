	#include "p16f685.inc"

	radix decimal

	udata
	global shiftRegisterBuffer

shiftRegisterBuffer res 1

ShiftOutDummy code
	global shiftOut

shiftOut:
	return

	end
