	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Smps.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global numberOfEnableCalls
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

EnableSmpsTest code
	global testArrange

testArrange:
	fcall initialiseSmps

testAct:
	banksel numberOfEnableCalls
	movf numberOfEnableCalls
	btfsc STATUS, Z
	goto callDisableSmps

callEnableSmps:
	fcall enableSmps
	banksel numberOfEnableCalls
	decfsz numberOfEnableCalls
	goto testAct

callDisableSmps:
	banksel numberOfDisableCalls
	movf numberOfDisableCalls
	btfsc STATUS, Z
	goto testAssert

callDisableSmpsInLoop:
	fcall disableSmps
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
