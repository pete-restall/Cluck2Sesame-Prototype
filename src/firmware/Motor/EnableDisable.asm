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
	; TODO: BUG !  PORTC RMW OPERATION MEANS RC6 IS HIGH, SINCE SOMETHING ELSE HAS WRITTEN TO PORC AFTER initialiseMotor() !

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
	movlw 0
	banksel enableMotorVddCount
	movf enableMotorVddCount
	btfsc STATUS, Z
	return

	tcall isSmpsEnabled

	end
