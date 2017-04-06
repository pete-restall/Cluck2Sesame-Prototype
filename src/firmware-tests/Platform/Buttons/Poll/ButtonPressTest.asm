	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Timer0.inc"
	#include "Buttons.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global expectedButton1State
	global expectedButton2State
	global expectedBothButtonsState

expectedButton1State res 1
expectedButton2State res 1
expectedBothButtonsState res 1

ButtonPressTest code
	global testArrange

testArrange:
	fcall initialiseTimer0
	call initialiseTimer1
	call initialisePortc
	fcall initialiseButtons

	call startTimer1

	banksel TMR1L
synchroniseWithStimuli:
	movf TMR1L, W
	btfsc STATUS, Z
	goto synchroniseWithStimuli
	clrf TMR1L

signalThatTheButtonStimuliCanBeApplied:
	banksel PORTC
	movlw (1 << RC1) | (1 << RC2)
	iorwf PORTC

testAct:
	fcall pollButtons
	banksel TMR1L
	movf TMR1L, W
	btfsc STATUS, Z
	goto testAct

testAssert:
assertButton1:
	banksel buttonFlags
	movlw 0
	btfsc buttonFlags, BUTTON_FLAG_PRESSED1
	movlw 0xff

	banksel expectedButton1State
	movf expectedButton1State
	btfss STATUS, Z
	goto assertButton1IsPressed

assertButton1IsReleased:
	.aliasWForAssert _a
	.assert "_a == 0, 'Expected button 1 to be released.'"
	goto assertButton2

assertButton1IsPressed:
	.aliasWForAssert _a
	.assert "_a != 0, 'Expected button 1 to be pressed.'"

assertButton2:
	banksel buttonFlags
	movlw 0
	btfsc buttonFlags, BUTTON_FLAG_PRESSED2
	movlw 0xff

	banksel expectedButton2State
	movf expectedButton2State
	btfss STATUS, Z
	goto assertButton2IsPressed

assertButton2IsReleased:
	.aliasWForAssert _a
	.assert "_a == 0, 'Expected button 2 to be released.'"
	goto assertBothButtons

assertButton2IsPressed:
	.aliasWForAssert _a
	.assert "_a != 0, 'Expected button 2 to be pressed.'"

assertBothButtons:
	banksel buttonFlags
	movlw 0
	btfsc buttonFlags, BUTTON_FLAG_PRESSEDBOTH
	movlw 0xff

	banksel expectedBothButtonsState
	movf expectedBothButtonsState
	btfss STATUS, Z
	goto assertBothButtonsArePressed

assertBothButtonsAreReleased:
	.aliasWForAssert _a
	.assert "_a == 0, 'Expected both buttons to be released.'"
	return

assertBothButtonsArePressed:
	.aliasWForAssert _a
	.assert "_a != 0, 'Expected both buttons to be pressed.'"
	return

initialiseTimer1:
	banksel T1CON
	movlw (1 << TMR1CS)
	movwf T1CON

	banksel TMR1H
	clrf TMR1H
	clrf TMR1L
	return

startTimer1:
	banksel T1CON
	bsf T1CON, TMR1ON
	return

initialisePortc:
	banksel ANSEL
	movlw ~((1 << ANS5) | (1 << ANS6))
	andwf ANSEL

	banksel PORTC
	movlw ~((1 << RC1) | (1 << RC2))
	andwf PORTC

	banksel TRISC
	movlw ~((1 << TRISC1) | (1 << TRISC2))
	andwf TRISC
	return

	end
