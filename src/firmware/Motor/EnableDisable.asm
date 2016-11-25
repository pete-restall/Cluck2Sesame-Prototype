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

	; TODO: If this is the first time that the VDD_MOTOR has been enabled then
	; we need to zero out the shift register BEFORE /VDD_MOTOR_EN goes low (ie.
	; VDD_MOTOR_EN is also /OE for the shift register).  This will prevent
	; undefined voltages and data on the LCD pins.

	banksel MOTOR_TRIS
	bcf MOTOR_TRIS, MOTOR_VDD_EN_PIN_TRIS

	banksel MOTOR_PORT
	bcf MOTOR_PORT, MOTOR_VDD_EN_PIN

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
	clrw
	banksel enableMotorVddCount
	movf enableMotorVddCount
	btfsc STATUS, Z
	return

	tcall isSmpsEnabled

	end
