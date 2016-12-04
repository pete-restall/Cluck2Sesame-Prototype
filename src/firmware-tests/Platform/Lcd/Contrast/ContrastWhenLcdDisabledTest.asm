	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Adc.inc"
	#include "Isr.inc"
	#include "Lcd.inc"
	#include "TestFixture.inc"

	radix decimal

ContrastWhenLcdDisabledTest code
	global testArrange

testArrange:
	fcall initialiseAdc
	fcall initialiseLcd
	fcall initialiseIsr

enableInterrupts:
	banksel INTCON
	movlw (1 << PEIE) | (1 << GIE)
	movwf INTCON

	fcall enableLcd

waitUntilLcdIsEnabled:
	fcall pollLcd
	fcall isLcdEnabled
	sublw 0
	btfsc STATUS, Z
	goto waitUntilLcdIsEnabled

testAct:
	fcall disableLcd

logTraceUntilTimerOverflows:
	call waitForTimer1Overflow

testAssert:
	.assertTraceExternally
	return

waitForTimer1Overflow:
	banksel PIR1
	bcf PIR1, TMR1IF

	banksel TMR1H
	clrf TMR1H

	banksel TMR1L
	clrf TMR1L

	banksel T1CON
	movlw (1 << TMR1CS) | (1 << T1OSCEN)
	movwf T1CON
	bsf T1CON, TMR1ON

stillNotOverflowed:
	banksel PIR1
	btfss PIR1, TMR1IF
	goto stillNotOverflowed

stopTimer1:
	banksel T1CON
	bcf T1CON, TMR1ON

	banksel PIR1
	bcf PIR1, TMR1IF
	return

	end
