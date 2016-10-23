	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "TailCalls.inc"
	#include "../Smps.inc"
	#include "Motor.inc"

	radix decimal

	udata
	global enableMotorVddCount

enableMotorVddCount res 1

Motor code
	global enableMotorVdd
	global disableMotorVdd
	global isMotorVddEnabled

enableMotorVdd:
	fcall enableSmps

	banksel MOTOR_TRIS
	bcf MOTOR_TRIS, MOTOR_VDD_EN_PIN_TRIS

	banksel enableMotorVddCount
	incf enableMotorVddCount
	return

disableMotorVdd:
	banksel enableMotorVddCount
	decfsz enableMotorVddCount
	goto disableMotorVddReturn

	banksel MOTOR_TRIS
	bsf MOTOR_TRIS, MOTOR_VDD_EN_PIN_TRIS

disableMotorVddReturn:
	fcall disableSmps
	return

isMotorVddEnabled:
	tcall isSmpsEnabled

	end
