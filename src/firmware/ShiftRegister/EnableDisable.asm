	#include "p16f685.inc"
	#include "TailCalls.inc"
	#include "../Motor.inc"

	radix decimal

ShiftRegister code
	global enableShiftRegister
	global disableShiftRegister

enableShiftRegister:
	tcall enableMotorVdd

disableShiftRegister:
	tcall disableMotorVdd

	end
