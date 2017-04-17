	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Timer0.inc"
	#include "Smps.inc"
	#include "TestFixture.inc"

	radix decimal

DisableSmpsPicVddTest code
	global testArrange

testArrange:
	fcall initialiseTimer0
	fcall initialiseSmps

	fcall disableSmps
	fcall pollSmps

	fcall enableSmps

waitUntilSmpsEnabled:
	fcall pollSmps
	fcall isSmpsEnabled
	xorlw 0
	btfsc STATUS, Z
	goto waitUntilSmpsEnabled

testAct:
	fcall disableSmps

testAssert:
	banksel TRISB
	clrw
	btfsc TRISB, TRISB7
	movlw 1
	.aliasWForAssert _a
	.assert "W == 0, 'TRISB expectation mismatch - PIC_VDD_SMPS_EN should be pulled low since the SMPS is turning off.'"

	banksel PORTB
	clrw
	btfsc PORTB, RB7
	movlw 1
	.aliasWForAssert _a
	.assert "W == 0, 'PORTB expectation mismatch - PIC_VDD_SMPS_EN should be pulled low since the SMPS is turning off.'"

	return

	end
