	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "GeneralPurposeRegisters.inc"
	#include "Arithmetic4.inc"

	radix decimal

ArithmeticBcd code
	global bcdToBinary

bcdToBinary:
multiplyMsdByTen:
	banksel RAA
	swapf RAA
	movlw 10
	movwf RBA
	fcall mul4x4
	movwf RBA

addLsdToMultipleAndReturn:
	swapf RAA
	movlw 0x0f
	andwf RAA, W
	addwf RBA, W

	return

	end
