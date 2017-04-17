	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Timer0.inc"
	#include "Smps.inc"
	#include "TestFixture.inc"

	radix decimal

EnableSmpsPicVddTest code
	global testArrange

testArrange:
	fcall initialiseTimer0
	fcall initialiseSmps

	fcall disableSmps
	fcall pollSmps

testAct:
	fcall enableSmps

waitUntilSmpsEnabled:
	banksel TRISB
	clrw
	btfsc TRISB, TRISB7
	movlw 1
	.aliasWForAssert _a
	.assert "W == 0, 'TRISB expectation mismatch - PIC_VDD_SMPS_EN to be pulled low until VDD is stable.'"

	banksel PORTB
	clrw
	btfsc PORTB, RB7
	movlw 1
	.aliasWForAssert _a
	.assert "W == 0, 'RB7 expectation mismatch - PIC_VDD_SMPS_EN should be pulled low until VDD is stable.'"

	fcall pollSmps
	fcall isSmpsEnabled
	xorlw 0
	btfsc STATUS, Z
	goto waitUntilSmpsEnabled

testAssert:
	banksel TRISB
	clrw
	btfsc TRISB, TRISB7
	movlw 1
	.aliasWForAssert _a
	.assert "W != 0, 'TRISB expectation mismatch - PIC_VDD_SMPS_EN should be pulled high now that VDD is stable.'"

	return

	end
