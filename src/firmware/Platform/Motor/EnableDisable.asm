	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "TailCalls.inc"
	#include "../Smps.inc"
	#include "Motor.inc"

	radix decimal

Motor code
	global enableMotorVdd
	global disableMotorVdd
	global isMotorVddEnabled

enableMotorVdd:
	fcall enableSmps

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
	; TODO: DISABLE PWM PINS
	fcall disableSmps
	return

isMotorVddEnabled:
	clrw
	banksel enableMotorVddCount
	movf enableMotorVddCount
	btfsc STATUS, Z
	return

	; TODO: PROBABLY BEST TO WAIT FOR A FEW MILLISECONDS FOR THE VDD_MOTOR LINE
	; TO BECOME STABLE BEFORE RETURNING 'TRUE'.  ALSO, DUE TO THE TIMING OF THE
	; DELAY, IT WILL BE NECESSARY TO PREVENT SLEEPING AND CLOCK SWITCHING...

	tcall isSmpsEnabled

	end
