	#include "p16f685.inc"
	#include "TailCalls.inc"
	#include "../Motor.inc"
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
	tcall enableMotorVdd ; TODO: REPLACE THIS WITH enableSmps

disableShiftRegister:
	banksel SHIFT_REGISTER_PORT
	movlw ~ALL_SHIFT_REGISTER_PINS_MASK
	andwf SHIFT_REGISTER_PORT
	tcall disableMotorVdd ; TODO: REPLACE THIS WITH disableSmps

isShiftRegisterEnabled:
	tcall isMotorVddEnabled ; TODO: REPLACE THIS WITH isSmpsEnabled

	end
