	#include "Platform.inc"
	#include "TailCalls.inc"
	#include "Lcd/Isr.inc"
	#include "PowerManagement/Isr.inc"
	#include "Clock.inc"
	#include "Motor/Isr.inc"
	#include "InitialisationChain.inc"

	radix decimal

	extern INITIALISE_AFTER_ISR

MOTOR_ADC_CHANNEL equ b'00011100'
MOTOR_LOAD_FLAGS_MASK equ (1 << MOTOR_FLAG_NOLOAD) | (1 << MOTOR_FLAG_NOMINALLOAD) | (1 << MOTOR_FLAG_OVERLOAD)

ADRESH_90MA equ 23

	udata_shr
contextSavingW res 1
contextSavingStatus res 1
contextSavingPclath res 1
lcdContrastAccumulator res 1

Isr code 0x0004
	global isr
	global initialiseIsr

	; TODO: BUG (HERE ?) - LCD CONTRAST GOES FROM ABOUT 1.24V TO 2.38V
	; SEEMINGLY RANDOMLY, TURNING OFF THE LCD.  VOLTAGE IS ROCK SOLID UNTIL
	; IT HAPPENS, AND THERE IS NO CONSISTENT TIME UNTIL IT HAPPENS...
	;
	; *** UPDATE: I THINK THIS IS BECAUSE UNDER CERTAIN (UNKNOWN) CONDITIONS,
	; THE ADC IS TURNED OFF - PORTC5=1, TRISC=0x88, PSTRCON=0x11, CCPR1L=0xff,
	; ADCON=0x1f, ADCON1=0x20, motorState=0x05.  NOTICED DURING RAISING OF THE
	; DOOR DURING SIMULATION.

isr:
	movwf contextSavingW
	swapf contextSavingW
	swapf STATUS, W
	movwf contextSavingStatus
	movf PCLATH, W
	movwf contextSavingPclath
	clrf PCLATH

preventSleepForSinglePollLoopIteration:
	.setBankFor powerManagementFlags
	bsf powerManagementFlags, POWER_FLAG_PREVENTSLEEP

adcSampled:
	.safelySetBankFor PIR1
	btfss PIR1, ADIF
	goto endOfAdcBlock
	bcf PIR1, ADIF

disableMotorOutputsIfNotMonitoringCurrent:
	.setBankFor ADCON0
	bsf ADCON0, GO
	movlw b'00111100'
	andwf ADCON0, W
	xorlw MOTOR_ADC_CHANNEL
	btfss STATUS, Z
	goto disableMotorOutputs

motorCurrentMonitoring:
	.setBankFor PSTRCON
	movlw MOTOR_PSTRCON_OUTPUT_MASK
	andwf PSTRCON, W
	btfsc STATUS, Z
	goto endOfMotorCurrentMonitoring

setMotorFlags:
	.setBankFor ADRESH
	movlw ADRESH_90MA
	subwf ADRESH, W
	movlw ~MOTOR_LOAD_FLAGS_MASK | (1 << MOTOR_FLAG_NOLOAD)
	btfsc STATUS, C
	movlw ~MOTOR_LOAD_FLAGS_MASK | (1 << MOTOR_FLAG_NOMINALLOAD)
	btfsc ADRESH, 7
	movlw ~MOTOR_LOAD_FLAGS_MASK | (1 << MOTOR_FLAG_OVERLOAD)

	.setBankFor motorFlags
	andwf motorFlags
	andlw MOTOR_LOAD_FLAGS_MASK
	iorwf motorFlags

disableMotorOutputsIfFlagsMasked:
	swapf motorFlags, W
	andlw MOTOR_LOAD_FLAGS_MASK
	andwf motorFlags, W
	btfsc STATUS, Z
	goto endOfMotorCurrentMonitoring

disableMotorOutputs:
	.safelySetBankFor MOTOR_PORT
	bcf MOTOR_PORT, MOTOR_PWMA_PIN
	bcf MOTOR_PORT, MOTOR_PWMB_PIN

	.setBankFor PSTRCON
	movlw ~MOTOR_PSTRCON_OUTPUT_MASK
	andwf PSTRCON

endOfMotorCurrentMonitoring:
lcdDeltaSigmaContrastControl:
	.safelySetBankFor lcdFlags
	btfss lcdFlags, LCD_FLAG_ENABLED
	goto endOfContrastControl

	movf lcdContrast, W
	addwf lcdContrastAccumulator

	.setBankFor LCD_CONTRAST_PORT
	btfss STATUS, C
	bcf LCD_CONTRAST_PORT, LCD_CONTRAST_PIN
	btfsc STATUS, C
	bsf LCD_CONTRAST_PORT, LCD_CONTRAST_PIN

endOfContrastControl:
endOfAdcBlock:
clockTicked:
	.safelySetBankFor PIR1
	btfss PIR1, TMR1IF
	goto endOfClockTicked
	bcf PIR1, TMR1IF

	.setBankFor clockFlags
	bsf clockFlags, CLOCK_FLAG_TICKED

endOfClockTicked:
clearButtonFlagIfJustWokenUp:
	.safelySetBankFor powerManagementFlags
	btfss powerManagementFlags, POWER_FLAG_SLEEPING
	goto endOfIsr

	.setBankFor INTCON
	bcf INTCON, RABIF

endOfIsr:
	movf contextSavingPclath, W
	movwf PCLATH
	swapf contextSavingStatus, W
	movwf STATUS
	swapf contextSavingW, W
	retfie

initialiseIsr:
	clrf lcdContrastAccumulator
	tcall INITIALISE_AFTER_ISR

	end
