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
	; LCD V0 DAC counter:

	banksel PORTA
	bcf PORTA, RA1
	bcf PORTA, RA2

	banksel TRISA
	bcf TRISA, TRISA1
	bcf TRISA, TRISA2

	banksel ANSEL
	bcf ANSEL, ANS2
	bcf ANSEL, ANS7

	banksel ANSELH
	bcf ANSEL, ANS8
	bcf ANSEL, ANS9


	; LCD E = RB7
	; LCD RS = RC2
	; LCD D4 = RC7
	; LCD D5 = RC6
	; LCD D6 = RC3
	; LCD D7 = RC4
	banksel PORTB
	bcf PORTB, RB7

	banksel PORTC
	bcf PORTC, RC2
	bcf PORTC, RC3
	bcf PORTC, RC4
	bcf PORTC, RC6
	bcf PORTC, RC7

	banksel TRISB
	bcf TRISB, TRISB7

	banksel TRISC
	bcf TRISC, TRISC2
	bcf TRISC, TRISC3
	bcf TRISC, TRISC4
	bcf TRISC, TRISC6
	bcf TRISC, TRISC7
	call lcdEnterNibbleMode


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
	movlw b'00100000'
	movwf ADCON1

	banksel PIE1
	bsf PIE1, ADIE

	banksel INTCON
	bsf INTCON, PEIE
	bsf INTCON, GIE

	banksel ADCON0
	bsf ADCON0, GO

loop:
	goto loop

lcdEnterNibbleMode:
	movlw 40
	call delayNominalMilliseconds

	movlw b'00000011'
	call lcdSendNibble
	movlw 5
	call delayNominalMilliseconds

	movlw b'00000011'
	call lcdSendNibble
	movlw 1
	call delayNominalMilliseconds

	movlw b'00000011'
	call lcdSendNibble
	movlw 1
	call delayNominalMilliseconds

	movlw b'00000010'
	call lcdSendNibble
	movlw 1
	call delayNominalMilliseconds


	; Now in 4-bit mode:

	movlw b'00000010'
	call lcdSendNibble
	movlw b'00001000'
	call lcdSendNibble
	movlw 1
	call delayNominalMilliseconds

	movlw b'00000000'
	call lcdSendNibble
	movlw b'00001000'
	call lcdSendNibble
	movlw 1
	call delayNominalMilliseconds

	movlw b'00000000'
	call lcdSendNibble
	movlw b'00000001'
	call lcdSendNibble
	movlw 2
	call delayNominalMilliseconds

	movlw b'00000000'
	call lcdSendNibble
	movlw b'00000100'
	call lcdSendNibble
	movlw 1
	call delayNominalMilliseconds


	; Initialisation done, turn on the screen and blinking cursor:

	movlw b'00000000'
	call lcdSendNibble
	movlw b'00001110'
	call lcdSendNibble
	movlw 1
	call delayNominalMilliseconds

	return

delayNominalMilliseconds:
	movwf wTemp
delayOneMillisecond:
	movlw 50
delayOneMillisecondLoop:
	call delayTenMicroseconds
	nop
	nop
	nop
	nop
	nop
	nop
	addlw -1
	btfss STATUS, Z
	goto delayOneMillisecondLoop

	decfsz wTemp
	goto delayOneMillisecond
	return

delayTenMicroseconds:
	nop
	nop
	nop
	nop
	nop
	nop
	return

lcdSendNibble:
	; LCD E = RB7
	; LCD RS = RC2
	; LCD D4 = RC7
	; LCD D5 = RC6
	; LCD D6 = RC3
	; LCD D7 = RC4
	movwf wTemp
	btfss wTemp, 5
	goto lcdResetRs

lcdSetRs:
	banksel PORTC
	bsf PORTC, RC2
	goto lcdTestD4

lcdResetRs:
	banksel PORTC
	bcf PORTC, RC2

lcdTestD4:
	btfss wTemp, 0
	goto lcdResetD4

lcdSetD4:
	bsf PORTC, RC7
	goto lcdTestD5

lcdResetD4:
	bcf PORTC, RC7

lcdTestD5:
	btfss wTemp, 1
	goto lcdResetD5

lcdSetD5:
	bsf PORTC, RC6
	goto lcdTestD6

lcdResetD5:
	bcf PORTC, RC6

lcdTestD6:
	btfss wTemp, 2
	goto lcdResetD6

lcdSetD6:
	bsf PORTC, RC3
	goto lcdTestD7

lcdResetD6:
	bcf PORTC, RC3

lcdTestD7:
	btfss wTemp, 3
	goto lcdResetD7

lcdSetD7:
	bsf PORTC, RC4
	goto lcdPulseEnable

lcdResetD7:
	bcf PORTC, RC4

lcdPulseEnable:
	banksel PORTB
	bsf PORTB, RB7
	nop
	bcf PORTB, RB7
	return

	udata_shr
wTemp res 1

	end
