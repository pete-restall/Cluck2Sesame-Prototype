	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "TailCalls.inc"
	#include "../Smps.inc"
	#include "../Adc.inc"
	#include "Motor.inc"
	#include "States.inc"

	radix decimal

Motor code
	global enableMotorVdd
	global disableMotorVdd
	global isMotorVddEnabled

enableMotorVdd:
	fcall enableSmps
	fcall enableAdc

	banksel MOTOR_TRIS
	bcf MOTOR_TRIS, MOTOR_VDD_EN_PIN_TRIS

	banksel MOTOR_PORT
	bcf MOTOR_PORT, MOTOR_VDD_EN_PIN

	banksel enableMotorVddCount
	incf enableMotorVddCount

setMotorStateToIdleIfFirstCall:
	movlw 1
	xorwf enableMotorVddCount, W
	btfss STATUS, Z
	return

	movlw MOTOR_STATE_IDLE
	movwf motorState
	return

disableMotorVdd:
	banksel enableMotorVddCount
	decfsz enableMotorVddCount
	goto disableMotorVddReturn

	banksel MOTOR_TRIS
	bsf MOTOR_TRIS, MOTOR_VDD_EN_PIN_TRIS

	; TODO: DISABLE PWM PINS - UN-NECESSARY IF MOTOR IS *ALWAYS* STOPPED PRIOR
	; TO DISABLING THE MOTOR VDD
	banksel motorState
	movlw MOTOR_STATE_DISABLED
	movwf motorState

disableMotorVddReturn:
	fcall disableAdc
	tcall disableSmps

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
