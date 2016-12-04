	#include "p16f685.inc"
	#include "TestDoubles.inc"

	radix decimal

EnableDisableMotorVddStubs code
	global initialiseEnableAndDisableMotorVddStubs
	global enableMotorVdd
	global disableMotorVdd
	global isMotorVddEnabled

initialiseEnableAndDisableMotorVddStubs:
	return

enableMotorVdd:
	banksel TRISC
	bcf TRISC, TRISC6

	banksel PORTC
	bcf PORTC, RC6
	return

disableMotorVdd:
	banksel TRISC
	bsf TRISC, TRISC6
	return

isMotorVddEnabled:
	retlw 1

	end
