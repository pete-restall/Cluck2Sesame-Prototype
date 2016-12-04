	#include "p16f685.inc"
	#include "TailCalls.inc"
	#include "../Smps.inc"
	#include "ShiftRegister.inc"

	radix decimal

ALL_SHIFT_REGISTER_PINS_MASK equ DS_PIN_MASK | SHCP_PIN_MASK | STCP_PIN_MASK

ShiftRegister code
	global enableShiftRegister
	global disableShiftRegister
	global isShiftRegisterEnabled

enableShiftRegister:
	banksel SHIFT_REGISTER_PORT
	movlw ~ALL_SHIFT_REGISTER_PINS_MASK
	andwf SHIFT_REGISTER_PORT
	tcall enableSmps

disableShiftRegister:
	banksel SHIFT_REGISTER_PORT
	movlw ~ALL_SHIFT_REGISTER_PINS_MASK
	andwf SHIFT_REGISTER_PORT
	tcall disableSmps

isShiftRegisterEnabled:
	tcall isSmpsEnabled

	end
