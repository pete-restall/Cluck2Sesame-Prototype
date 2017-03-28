	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "Lcd/Isr.inc"
	#include "PowerManagement/PowerManagement.inc"
	#include "Clock.inc"
	#include "Motor.inc"
	#include "InitialisationChain.inc"

	radix decimal

	extern INITIALISE_AFTER_ISR

MOTOR_LOAD_FLAGS_MASK equ (1 << MOTOR_FLAG_NOLOAD) | (1 << MOTOR_FLAG_NOMINALLOAD) | (1 << MOTOR_FLAG_OVERLOAD)
MOTOR_PSTRCON_OUTPUT_MASK equ ~(1 << STRSYNC)

	udata_shr
contextSavingW res 1
contextSavingStatus res 1
lcdContrastAccumulator res 1

Isr code 0x0004
	global isr
	global initialiseIsr

	; TODO: MIGHT NEED TO BUMP MCU FREQUENCY TO 8MHz - 73 CYCLES (OR THEREABOUTS) OUT OF 88 USED IN WORST-CASE...

isr:
	; Context saving - note swapf does not alter any STATUS bits, movf does:

	movwf contextSavingW
	swapf contextSavingW
	swapf STATUS, W
	movwf contextSavingStatus

adcSampled:
	banksel ADCON0
	bsf ADCON0, GO

preventSleepForSinglePollLoopIteration:
	banksel powerManagementFlags
	bsf powerManagementFlags, POWER_FLAG_PREVENTSLEEP

	banksel PIR1
	btfss PIR1, ADIF
	goto clockTicked
	bcf PIR1, ADIF

motorCurrentMonitoring:
	; TODO: THIS IS ONLY REQUIRED IF THE ADC CHANNEL IS THE MOTOR CHANNEL...
	banksel PSTRCON
	movlw MOTOR_PSTRCON_OUTPUT_MASK
	andwf PSTRCON, W
	btfsc STATUS, Z
	goto endOfMotorCurrentMonitoring

setMotorFlags:
	banksel ADRESH
	movlw 1 << MOTOR_FLAG_NOLOAD
	btfsc ADRESH, 6
	movlw 1 << MOTOR_FLAG_NOMINALLOAD
	btfsc ADRESH, 7
	movlw 1 << MOTOR_FLAG_OVERLOAD

	banksel motorFlags
	iorwf motorFlags
	xorlw 0xff
	xorlw MOTOR_LOAD_FLAGS_MASK
	andwf motorFlags

disableMotorOutputsIfFlagsMasked:
	swapf motorFlags, W
	andlw MOTOR_LOAD_FLAGS_MASK
	andwf motorFlags, W
	movlw 0xff
	btfss STATUS, Z
	movlw ~MOTOR_PSTRCON_OUTPUT_MASK
	banksel PSTRCON
	andwf PSTRCON

endOfMotorCurrentMonitoring:
lcdDeltaSigmaContrastControl:
	banksel lcdFlags ; TODO: MAKE ALL LCD VARIABLES OF THE SAME BANK !
	btfss lcdFlags, LCD_FLAG_ENABLED
	goto clockTicked

	banksel lcdContrast
	movf lcdContrast, W
	addwf lcdContrastAccumulator

	banksel LCD_CONTRAST_PORT
	movf LCD_CONTRAST_PORT, W
	andlw ~LCD_CONTRAST_PIN_MASK
	btfsc STATUS, C
	iorlw LCD_CONTRAST_PIN_MASK
	movwf LCD_CONTRAST_PORT

clockTicked:
	banksel PIR1
	btfss PIR1, TMR1IF
	goto endOfIsr
	bcf PIR1, TMR1IF

	banksel clockFlags
	bsf clockFlags, CLOCK_FLAG_TICKED

endOfIsr:
	swapf contextSavingStatus, W
	movwf STATUS
	swapf contextSavingW, W
	retfie

initialiseIsr:
	clrf lcdContrastAccumulator
	tcall INITIALISE_AFTER_ISR

	end
