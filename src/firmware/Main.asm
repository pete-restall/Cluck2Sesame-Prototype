	#include "P16F685.INC"
	radix decimal

	code
	global main

main:
	extern initialiseAfterPowerOnReset
	extern initialiseAfterBrownOutReset

	banksel PCON
	btfss PCON, NOT_POR
	call initialiseAfterPowerOnReset
	call initialiseAfterBrownOutReset

; ******** TEMPORARY BREADBOARDING CODE BELOW ********
breadboard:
	; PWM stuff for measuring current consumption:

	banksel CCPR1L
	movlw 50 >> 2
	movwf CCPR1L

	banksel CCP1CON
	movlw b'10001100'
	movwf CCP1CON

	banksel PR2
	movlw 24
	movwf PR2 ; 80kHz

	banksel T2CON
	bsf T2CON, TMR2ON

	banksel TRISC
	bcf TRISC, TRISC5


	; ADC sampling stuff for testing motor currents:

	banksel ANSEL
	bcf ANSEL, ANS5

	banksel PORTB
	clrf PORTB

	banksel TRISB
	bcf TRISB, TRISB4
	bcf TRISB, TRISB5

	banksel ADCON0
	movlw b'00010101'
	movwf ADCON0

	banksel ADCON1
	movlw b'00010000'
	movwf ADCON1

	banksel ADCON0
	bsf ADCON0, GO

	; Continually take ADC samples of the current sense resistor (minimum 22us per sample), setting pins:
	;     RB5 = 1 if sample > STALL CURRENT, else 0
	;     RB4 = 1 if sample < IDLE CURRENT, else 0
loop:
	btfsc ADCON0, GO
	goto loop
	bsf ADCON0, GO

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

	goto loop

idleCurrent:
	banksel PORTB
	bsf PORTB, RB4
	bcf PORTB, RB5
	goto loop

stallCurrent:
	banksel PORTB
	bcf PORTB, RB4
	bsf PORTB, RB5
	goto loop

	end
