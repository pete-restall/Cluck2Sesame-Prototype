	#include "Platform.inc"
	#include "ShiftRegister.inc"

	radix decimal

ShiftRegisterRam udata
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
	.knownBank SHIFT_REGISTER_PORT
	bsf SHIFT_REGISTER_PORT, STCP_PIN
	bcf SHIFT_REGISTER_PORT, STCP_PIN

adjustShiftRegisterBufferToAppearUnmodified:
	.setBankFor shiftRegisterBuffer
	rlf shiftRegisterBuffer
	return

shiftOutNextBit:
	.safelySetBankFor shiftRegisterBuffer
	rlf shiftRegisterBuffer

shiftOutCarry:
	.setBankFor SHIFT_REGISTER_PORT
	bcf SHIFT_REGISTER_PORT, DS_PIN
	btfsc STATUS, C
	bsf SHIFT_REGISTER_PORT, DS_PIN

	bsf SHIFT_REGISTER_PORT, SHCP_PIN
	bcf SHIFT_REGISTER_PORT, SHCP_PIN
	return

	end
