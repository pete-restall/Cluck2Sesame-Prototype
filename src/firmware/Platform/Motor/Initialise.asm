	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"
	#include "Motor.inc"

	radix decimal

	extern INITIALISE_AFTER_MOTOR
	extern enableMotorVddCount

PR2_FOR_15_625KHZ_PWM equ 63
CCP1CON_SINGLEPWM_MASK equ 0
CCP1CON_ALLPWMACTIVEHIGH_MASK equ b'00001100'

Motor code
	global initialiseMotor

initialiseMotor:
	banksel enableMotorVddCount
	clrf enableMotorVddCount

setMotorCurrentSensePortToAnalogue:
	banksel ANSEL
	bsf ANSEL, MOTOR_ISENSE_PIN_ANSL

setMotorVddEnablePortToAnalogue:
	banksel ANSELH
	bsf ANSELH, MOTOR_VDD_EN_PIN_ANSH

clearDigitalOutputs:
	banksel MOTOR_PORT
	movlw ~(MOTOR_VDD_EN_PIN_MASK | MOTOR_PWMA_PIN_MASK | MOTOR_PWMB_PIN_MASK)
	andwf MOTOR_PORT

setPortDirections:
	banksel MOTOR_TRIS
	bsf MOTOR_TRIS, MOTOR_VDD_EN_PIN_TRIS
	bsf MOTOR_TRIS, MOTOR_ISENSE_PIN_TRIS
	bcf MOTOR_TRIS, MOTOR_PWMA_PIN_TRIS
	bcf MOTOR_TRIS, MOTOR_PWMB_PIN_TRIS

configurePwmModule:
	banksel T2CON
	clrf T2CON

	banksel PR2
	movlw PR2_FOR_15_625KHZ_PWM
	movwf PR2

	banksel CCP1CON
	movlw CCP1CON_SINGLEPWM_MASK | CCP1CON_ALLPWMACTIVEHIGH_MASK
	movwf CCP1CON

	banksel CCPR1L
	clrf CCPR1L

	banksel PSTRCON
	movlw 1 << STRSYNC
	movwf PSTRCON

	tcall INITIALISE_AFTER_MOTOR

	end
