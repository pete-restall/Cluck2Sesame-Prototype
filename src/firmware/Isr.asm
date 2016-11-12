	#include "p16f685.inc"
	#include "Lcd/Isr.inc"
	#include "Clock.inc"

	radix decimal

	udata_shr
contextSavingW res 1
contextSavingStatus res 1
contextSavingPclath res 1
lcdContrastToggle res 1 ; TODO: THIS NEEDS INITIALISING !

Isr code 0x0004
	; Context saving - note swapf does not alter any STATUS bits, movf does:

	movwf contextSavingW
	swapf contextSavingW
	swapf STATUS, W
	movwf contextSavingStatus
	movf PCLATH, W
	movwf contextSavingPclath
	clrf PCLATH

adcSampled:
	banksel ADCON0
	bsf ADCON0, GO

	banksel PIR1
	btfss PIR1, ADIF
	goto clockTicked
	bcf PIR1, ADIF

lcdDeltaSigmaContrastControl:
	; TODO: THIS SHOULD ONLY HAPPEN WHEN THE LCD MODULE IS ENABLED (lcdFlags & LCD_FLAG_ENABLED)

	; TODO: THIS IS ALL TEMPORARY - 50% DUTY CYCLE AT ~5.5kHz; SHOULD BE A DELTA-SIGMA MODULATED DAC...

	banksel LCD_CONTRAST_PORT
	movf lcdContrastToggle, W
	xorwf LCD_CONTRAST_PORT
	xorlw LCD_CONTRAST_PIN_MASK
	;bsf LCD_CONTRAST_PORT, LCD_CONTRAST_PIN
	movwf lcdContrastToggle

clockTicked:
	; TODO: TEST AND IMPLEMENT TO ENSURE THAT THIS DOES NOT INCREMENT FOR AN AD CONVERSION !  IE. ENSURE PIR1.TMRIF != 0 !
	banksel clockFlags
	bsf clockFlags, CLOCK_FLAG_TICKED

	banksel PIR1
	bcf PIR1, TMR1IF

endOfIsr:
	movf contextSavingPclath, W
	movwf PCLATH
	swapf contextSavingStatus, W
	movwf STATUS
	swapf contextSavingW, W
	retfie

	end
