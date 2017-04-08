	#include "Platform.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"
	#include "Motor.inc"
	#include "States.inc"

	radix decimal

	extern INITIALISE_AFTER_MOTOR

PR2_FOR_15_625KHZ_PWM equ 63
CCP1CON_SINGLEPWM_MASK equ 0
CCP1CON_ALLPWMACTIVEHIGH_MASK equ b'00001100'

Motor code
	global initialiseMotor

initialiseMotor:
	.safelySetBankFor enableMotorVddCount
	clrf enableMotorVddCount
	clrf motorState

	movlw MOTOR_FLAG_PREVENT_OVERLOAD
	movwf motorFlags

setMotorCurrentSensePortToAnalogue:
	.setBankFor ANSEL
	bsf ANSEL, MOTOR_ISENSE_PIN_ANSL

setMotorVddEnablePortToAnalogue:
	.setBankFor ANSELH
	bsf ANSELH, MOTOR_VDD_EN_PIN_ANSH

clearDigitalOutputs:
	.setBankFor MOTOR_PORT
	movlw ~(MOTOR_VDD_EN_PIN_MASK | MOTOR_PWMA_PIN_MASK | MOTOR_PWMB_PIN_MASK)
	andwf MOTOR_PORT

setPortDirections:
	.setBankFor MOTOR_TRIS
	bsf MOTOR_TRIS, MOTOR_VDD_EN_PIN_TRIS
	bsf MOTOR_TRIS, MOTOR_ISENSE_PIN_TRIS
	bcf MOTOR_TRIS, MOTOR_PWMA_PIN_TRIS
	bcf MOTOR_TRIS, MOTOR_PWMB_PIN_TRIS

configurePwmModule:
	.setBankFor T2CON
	clrf T2CON

	.setBankFor PR2
	movlw PR2_FOR_15_625KHZ_PWM
	movwf PR2

	.setBankFor CCP1CON
	movlw CCP1CON_SINGLEPWM_MASK | CCP1CON_ALLPWMACTIVEHIGH_MASK
	movwf CCP1CON

	.setBankFor CCPR1L
	clrf CCPR1L

	.setBankFor PSTRCON
	movlw 1 << STRSYNC
	movwf PSTRCON

	tcall INITIALISE_AFTER_MOTOR

	end
