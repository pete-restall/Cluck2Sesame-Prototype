	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "ShiftRegister.inc"
	#include "../EnableDisableMotorVddStubs.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global initialShiftRegisterBuffer

initialShiftRegisterBuffer res 1
shiftedValue res 1

ShiftOutTest code
	global testArrange

testArrange:
	fcall initialiseEnableAndDisableMotorVddStubs
	call initialisePinsForShiftRegisterLoopback
	fcall initialiseShiftRegister
	fcall enableShiftRegister
	fcall enableMotorVdd

testAct:
	banksel initialShiftRegisterBuffer
	movf initialShiftRegisterBuffer, W

	banksel shiftRegisterBuffer
	movwf shiftRegisterBuffer
	fcall shiftOut

testAssert:
	call reconstructShiftedValueFromLoopedStimuli

	.aliasForAssert shiftRegisterBuffer, _a
	.aliasForAssert initialShiftRegisterBuffer, _b
	.assert "_a == _b, 'Expected shiftBuffer == initialShiftRegisterBuffer.'"

	.aliasForAssert shiftedValue, _a
	.aliasForAssert shiftRegisterBuffer, _b
	.assert "_a == _b, 'Expected shiftedValue == shiftRegisterBuffer.'"
	return

initialisePinsForShiftRegisterLoopback:
	; Unfortunately gpsim doesn't allow assertions on stimuli attributes, so
	; we create a loopback from the shift register's output into free ports:

	banksel ANSEL
	bcf ANSEL, ANS0
	bcf ANSEL, ANS1
	bcf ANSEL, ANS2
	bcf ANSEL, ANS7

	banksel ANSELH
	bcf ANSELH, ANS10
	bcf ANSELH, ANS11
	return

reconstructShiftedValueFromLoopedStimuli:
	banksel PORTB
	movlw b'11110000'
	andwf PORTB, W
	banksel shiftedValue
	movwf shiftedValue

	banksel PORTA
	movlw b'00000111'
	andwf PORTA, W
	banksel shiftedValue
	iorwf shiftedValue

	banksel PORTC
	movlw 0
	btfsc PORTC, RC3
	movlw b'00001000'
	banksel shiftedValue
	iorwf shiftedValue
	return

	end
