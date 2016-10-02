	#include "p16f685.inc"
	radix decimal

	udata_shr
contextSavingW res 1
contextSavingStatus res 1

	udata  ; ******** TEMPORARY BREADBOARDING DATA ********
lcdDacValue res 1
lcdDacError res 1
lcdDacTimingEdge res 1

Isr code
	global isrInitialise

isrInitialise:
	banksel lcdDacValue
	movlw 50 ; 255 * xV / 3.3V
	movwf lcdDacValue
	clrf lcdDacError
	clrf lcdDacTimingEdge
	return

isr code 0x0004
	; Context saving - note swapf does not alter any STATUS bits, movf does:

	movwf contextSavingW
	swapf contextSavingW
	swapf STATUS, W
	movwf contextSavingStatus

; ******** START TEMPORARY BREADBOARDING CODE ********
	banksel PIR1
	btfss PIR1, ADIF
	goto endOfIsr
	bcf PIR1, ADIF

	banksel ADCON0
	bsf ADCON0, GO

	banksel PORTA
	movlw 1 << RA2
	;xorwf PORTA

	; LCD DELTA SIGMA START
	; ISR frequency is halved to allow rising and falling edges to be generated.
	; Ensure that 'edge', 'lcdDacError' and 'lcdDacValue' are all in the same bank:

	banksel lcdDacTimingEdge
	movlw -1
	xorwf lcdDacTimingEdge
	;;;btfss STATUS, Z
	goto lcdDacRisingEdge

lcdDacFallingEdge:
	banksel PORTA
	bcf PORTA, RA1
	goto reactToAdcSample

lcdDacRisingEdge:
	movf lcdDacValue, W
	subwf lcdDacError, W
	movf STATUS, W
	andlw (1 << C) | (1 << Z)
	btfsc STATUS, Z ; If Z then C and Z not set, so lcdDacError > lcdDacValue
	goto lcdDacValueLtError

lcdDacValueGtOrEqToError:
	banksel PORTA
	bcf PORTA, RA1


	; lcdDacError += 1 - lcdDacValue:

	banksel lcdDacError
	incf lcdDacError
	movf lcdDacValue, W
	subwf lcdDacError
	goto reactToAdcSample

lcdDacValueLtError:
	banksel PORTA
	bsf PORTA, RA1


	; lcdDacError += -1 - lcdDacValue:

	banksel lcdDacError
	decf lcdDacError
	movf lcdDacValue, W
	subwf lcdDacError

	; LCD DELTA SIGMA END

	;     RB5 = 1 if sample > STALL CURRENT, else 0
	;     RB4 = 1 if sample < IDLE CURRENT, else 0
reactToAdcSample:
	banksel ADRESH
	movlw b'00011110' ; Idle current
 	subwf ADRESH, W
	btfss STATUS, C
	goto idleCurrent

	movlw b'01100100' ; Stall current
	subwf ADRESH, W
	btfsc STATUS, C
	goto stallCurrent

	banksel PORTB
	bcf PORTB, RB4
	bcf PORTB, RB5

	goto endOfIsr

idleCurrent:
	banksel PORTB
	bsf PORTB, RB4
	bcf PORTB, RB5
	goto endOfIsr

stallCurrent:
	banksel PORTB
	bcf PORTB, RB4
	bsf PORTB, RB5

; ******** END TEMPORARY BREADBOARDING CODE ********

endOfIsr:
	swapf contextSavingStatus, W
	movwf STATUS
	swapf contextSavingW, W
	retfie

	end
