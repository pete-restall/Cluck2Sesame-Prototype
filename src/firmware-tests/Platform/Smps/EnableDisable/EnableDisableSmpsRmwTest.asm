	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Smps.inc"
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

EnableSmpsRwmTest code
	global testArrange

testArrange:
	fcall initialiseSmps
	call triggerReadModifyWriteOnPortc
	fcall disableSmps
	call triggerReadModifyWriteOnPortc

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

	call triggerReadModifyWriteOnPortc

callDisableSmps:
	banksel numberOfDisableCalls
	movf numberOfDisableCalls
	btfsc STATUS, Z
	goto afterEnableAndDisableCalls

callDisableSmpsInLoop:
	fcall disableSmps
	banksel numberOfDisableCalls
	decfsz numberOfDisableCalls
	goto callDisableSmpsInLoop

afterEnableAndDisableCalls:
	call triggerReadModifyWriteOnPortc

testAssert:
	banksel ANSELH
	bcf ANSELH, ANS9

	banksel PORTC
	movlw 0
	btfsc PORTC, RC7
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
