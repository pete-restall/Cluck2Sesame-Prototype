	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Smps.inc"
	#include "TestFixture.inc"

	radix decimal

	extern doEnableCall
	extern doDisableCall

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

EnableDisableSmpsTestFixture code
	global testArrange

testArrange:
	fcall initialiseSmps

testAct:
	banksel numberOfEnableCalls
	movf numberOfEnableCalls
	btfsc STATUS, Z
	goto callDisableSmps

callEnableSmps:
	fcall doEnableCall
	banksel numberOfEnableCalls
	decfsz numberOfEnableCalls
	goto callEnableSmps

callDisableSmps:
	banksel numberOfDisableCalls
	movf numberOfDisableCalls
	btfsc STATUS, Z
	goto testAssert

callDisableSmpsInLoop:
	fcall doDisableCall
	banksel numberOfDisableCalls
	decfsz numberOfDisableCalls
	goto callDisableSmpsInLoop

testAssert:
	banksel PORTC
	movlw 0
	btfsc PORTC, RC7
	movlw 1

	banksel portValue
	movwf portValue

	banksel TRISC
	movlw 0
	btfsc TRISC, TRISC7
	movlw 1

	banksel trisValue
	movwf trisValue

	.assert "portValue == expectedPortValue, 'PORTC expectation failure.'"
	.assert "trisValue == expectedTrisValue, 'TRISC expectation failure.'"
	return

	end
