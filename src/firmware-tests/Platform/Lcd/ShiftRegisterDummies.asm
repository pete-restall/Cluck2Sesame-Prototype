	#include "p16f685.inc"

	radix decimal

	udata
	global shiftRegisterBuffer

shiftRegisterBuffer res 1

ShiftRegisterDummies code
	global initialiseShiftRegister
	global enableShiftRegister
	global disableShiftRegister
	global isShiftRegisterEnabled
	global shiftOut

initialiseShiftRegister:
enableShiftRegister:
disableShiftRegister:
shiftOut:
	return

isShiftRegisterEnabled:
	retlw 0

	end
