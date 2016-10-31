	#include "p16f685.inc"
	#include "TestDoubles.inc"

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
	movlw 1
	return

	end
