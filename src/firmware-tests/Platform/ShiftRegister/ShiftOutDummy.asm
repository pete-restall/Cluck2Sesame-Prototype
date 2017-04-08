	#include "Platform.inc"

	radix decimal

ShiftRegisterRam udata
	global shiftRegisterBuffer

shiftRegisterBuffer res 1

ShiftOutDummy code
	global shiftOut

shiftOut:
	return

	end
