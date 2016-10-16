	#include "p16f685.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"
	#include "Motor.inc"

	radix decimal

	extern INITIALISE_AFTER_MOTOR

Motor code
	global initialiseMotor

initialiseMotor:
setPortModes:
	banksel ANSEL
	bsf ANSEL, MOTOR_ISENSE_PIN_ANSL

	banksel ANSELH
	bcf ANSELH, MOTOR_VDD_EN_PIN_ANSH

clearDigitalOutputs:
	banksel MOTOR_PORT
	bcf MOTOR_PORT, MOTOR_VDD_EN_PIN
	bcf MOTOR_PORT, MOTOR_PWMA_PIN
	bcf MOTOR_PORT, MOTOR_PWMB_PIN

setPortDirections:
	banksel MOTOR_TRIS
	bsf MOTOR_TRIS, MOTOR_VDD_EN_PIN_TRIS
	bsf MOTOR_TRIS, MOTOR_ISENSE_PIN_TRIS
	bcf MOTOR_TRIS, MOTOR_PWMA_PIN_TRIS
	bcf MOTOR_TRIS, MOTOR_PWMB_PIN_TRIS

	tcall INITIALISE_AFTER_MOTOR

	end
