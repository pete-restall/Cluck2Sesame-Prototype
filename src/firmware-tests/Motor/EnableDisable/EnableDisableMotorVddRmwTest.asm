	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global numberOfEnableCalls
	global numberOfDisableCalls
	global expectedPortValue
	global portValue

numberOfEnableCalls res 1
numberOfDisableCalls res 1
expectedPortValue res 1
portValue res 1

EnableMotorVddRmwTest code
	global testArrange

testArrange:
	fcall initialiseMotor
	call triggerReadModifyWriteOnPortc

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

	call triggerReadModifyWriteOnPortc

callDisableMotorVdd:
	banksel numberOfDisableCalls
	movf numberOfDisableCalls
	btfsc STATUS, Z
	goto afterEnableAndDisableCalls

callDisableMotorVddInLoop:
	fcall disableMotorVdd
	banksel numberOfDisableCalls
	decfsz numberOfDisableCalls
	goto callDisableMotorVddInLoop

afterEnableAndDisableCalls:
	call triggerReadModifyWriteOnPortc

testAssert:
	banksel PORTC
	movlw 0
	btfsc PORTC, RC6
	movlw 1

	banksel portValue
	movwf portValue

	.assert "portValue == expectedPortValue, 'PORTC expectation failure.'"
	return

triggerReadModifyWriteOnPortc:
	banksel PORTC
	movf PORTC
	return

	end
