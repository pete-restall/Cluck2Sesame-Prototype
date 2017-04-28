	#include "Platform.inc"
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
	fcall enableSmpsHighPowerMode
	fcall enableAdc

	.setBankFor MOTOR_TRIS
	bcf MOTOR_TRIS, MOTOR_VDD_EN_PIN_TRIS

	.setBankFor MOTOR_PORT
	movlw (1 << MOTOR_VDD_EN_PIN) | (1 << MOTOR_PWMA_PIN) | (1 << MOTOR_PWMB_PIN)
	andwf MOTOR_PORT

	.setBankFor enableMotorVddCount
	incf enableMotorVddCount

returnIfNotFirstCallToEnableMotorVdd:
	decfsz enableMotorVddCount, W
	return

setMotorStateToIdle:
	movlw MOTOR_STATE_IDLE
	movwf motorState

startPwmTimer:
	.setBankFor TMR2
	clrf TMR2
	.setBankFor T2CON
	bsf T2CON, TMR2ON
	return

disableMotorVdd:
	.safelySetBankFor enableMotorVddCount
	decfsz enableMotorVddCount
	goto disableMotorVddReturn

	.setBankFor MOTOR_TRIS
	movlw (1 << MOTOR_VDD_EN_PIN_TRIS) | (1 << MOTOR_PWMA_PIN_TRIS) | (1 << MOTOR_PWMB_PIN_TRIS)
	iorwf MOTOR_TRIS

	.setBankFor motorState
	movlw MOTOR_STATE_DISABLED
	movwf motorState

	.setBankFor T2CON
	bcf T2CON, TMR2ON

disableMotorVddReturn:
	fcall disableAdc
	tcall disableSmpsHighPowerMode

isMotorVddEnabled:
	clrw
	.safelySetBankFor enableMotorVddCount
	movf enableMotorVddCount
	btfsc STATUS, Z
	return

	; TODO: PROBABLY BEST TO WAIT FOR A FEW MILLISECONDS FOR THE VDD_MOTOR LINE
	; TO BECOME STABLE BEFORE RETURNING 'TRUE'.  ALSO, DUE TO THE TIMING OF THE
	; DELAY, IT WILL BE NECESSARY TO PREVENT SLEEPING AND CLOCK SWITCHING...

	tcall isSmpsEnabled

	end
