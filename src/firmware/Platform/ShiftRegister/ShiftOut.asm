	#include "p16f685.inc"
	#include "ShiftRegister.inc"

	radix decimal

	udata
	global shiftRegisterBuffer

shiftRegisterBuffer res 1

ShiftRegister code
	global shiftOut

shiftOut:
	call shiftOutNextBit
	call shiftOutNextBit
	call shiftOutNextBit
	call shiftOutNextBit
	call shiftOutNextBit
	call shiftOutNextBit
	call shiftOutNextBit
	call shiftOutNextBit

storeShiftedValue:
	bsf SHIFT_REGISTER_PORT, STCP_PIN
	bcf SHIFT_REGISTER_PORT, STCP_PIN

adjustShiftRegisterBufferToAppearUnmodified:
	banksel shiftRegisterBuffer
	rlf shiftRegisterBuffer
	return

shiftOutNextBit:
	banksel shiftRegisterBuffer
	rlf shiftRegisterBuffer
	call shiftOutCarry
	return

shiftOutCarry:
	banksel SHIFT_REGISTER_PORT
	bcf SHIFT_REGISTER_PORT, DS_PIN
	btfsc STATUS, C
	bsf SHIFT_REGISTER_PORT, DS_PIN

	bsf SHIFT_REGISTER_PORT, SHCP_PIN
	bcf SHIFT_REGISTER_PORT, SHCP_PIN
	return

	end
