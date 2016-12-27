	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "Lcd/Isr.inc"
	#include "Clock.inc"
	#include "InitialisationChain.inc"

	radix decimal

	extern INITIALISE_AFTER_ISR

	udata_shr
contextSavingW res 1
contextSavingStatus res 1
contextSavingPclath res 1
lcdContrastAccumulator res 1

Isr code 0x0004
	global initialiseIsr

isr:
	; Context saving - note swapf does not alter any STATUS bits, movf does:

	movwf contextSavingW
	swapf contextSavingW
	swapf STATUS, W
	movwf contextSavingStatus
	movf PCLATH, W
	movwf contextSavingPclath
	clrf PCLATH

	; TODO: The ISR must prevent sleep because if it is called immediately
	; before the sleep call then there will be no polling loop iteration for
	; another 16 seconds.  The loop needs a chance to act on the ISR.

adcSampled:
	banksel ADCON0
	bsf ADCON0, GO

	banksel PIR1
	btfss PIR1, ADIF
	goto clockTicked
	bcf PIR1, ADIF

lcdDeltaSigmaContrastControl:
	banksel lcdFlags
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
