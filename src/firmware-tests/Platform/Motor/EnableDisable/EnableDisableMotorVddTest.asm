	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global numberOfEnableCalls
	global numberOfDisableCalls
	global expectedPortValue
	global expectedTrisValue
	global portValue
	global trisValue

numberOfEnableCalls res 1
numberOfDisableCalls res 1
expectedPortValue res 1
expectedTrisValue res 1

portValue res 1
trisValue res 1

EnableMotorVddTest code
	global testArrange

testArrange:
	fcall initialiseMotor

testAct:
	banksel numberOfEnableCalls
	movf numberOfEnableCalls
	btfsc STATUS, Z
	goto callDisableMotorVdd

callEnableMotorVdd:
	fcall enableMotorVdd
	banksel numberOfEnableCalls
	decfsz numberOfEnableCalls
	goto testAct

callDisableMotorVdd:
	banksel numberOfDisableCalls
	movf numberOfDisableCalls
	btfsc STATUS, Z
	goto testAssert

callDisableMotorVddInLoop:
	fcall disableMotorVdd
	banksel numberOfDisableCalls
	decfsz numberOfDisableCalls
	goto callDisableMotorVddInLoop

testAssert:
	banksel PORTC
	movlw 0
	btfsc PORTC, RC6
	movlw 1

	banksel portValue
	movwf portValue

	banksel TRISC
	movlw 0
	btfsc TRISC, TRISC6
	movlw 1

	banksel trisValue
	movwf trisValue

	.assert "portValue == expectedPortValue, 'PORTC expectation failure.'"
	.assert "trisValue == expectedTrisValue, 'TRISC expectation failure.'"
	return

	end
