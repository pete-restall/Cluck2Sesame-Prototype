	#include "p16f685.inc"
	#include "TailCalls.inc"
	#include "../Motor.inc"

	radix decimal

ShiftRegister code
	global enableShiftRegister
	global disableShiftRegister
	global isShiftRegisterEnabled

enableShiftRegister:
	tcall enableMotorVdd

disableShiftRegister:
	tcall disableMotorVdd

isShiftRegisterEnabled:
	; TODO: NEED TO CALL isMotorVddEnabled()
	return

	end
