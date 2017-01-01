	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Cordic.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global phiHigh
	global phiLow

phi:
phiHigh res 1
phiLow res 1

AllSineTest code
	global testArrange

testArrange:
	banksel phi
	clrf phiHigh
	clrf phiLow

	fcall initialiseCordic
	nop
	.direct "c", "symbol address=0"
	nop

testAct:
	loadSineArgument phi
	fcall sine

waitForResult:
	fcall pollCordic
	fcall isCordicIdle
	xorlw 0
	btfsc STATUS, Z
	goto waitForResult

storeResult:
	banksel phiHigh
	btfsc phiHigh, 7
	goto storeResultInThirdOrFourthEeprom

storeResultInFirstOrSecondEeprom:
	btfsc phiHigh, 6
	goto storeResultInSecondEeprom

storeResultInFirstEeprom:
	banksel cordicResult
	nop
	.direct "c", "eeprom0000_3fff.eeData[address] = 0 + cordicResultHigh"
	.direct "c", "eeprom0000_3fff.eeData[address + 1] = 0 + cordicResultLow"
	goto nextPhi

storeResultInSecondEeprom:
	nop
	banksel cordicResult
	nop
	.direct "c", "eeprom4000_7fff.eeData[address] = 0 + cordicResultHigh"
	.direct "c", "eeprom4000_7fff.eeData[address + 1] = 0 + cordicResultLow"
	goto nextPhi

storeResultInThirdOrFourthEeprom:
	btfsc phiHigh, 6
	goto storeResultInFourthEeprom

storeResultInThirdEeprom:
	banksel cordicResult
	nop
	.direct "c", "eeprom8000_bfff.eeData[address] = 0 + cordicResultHigh"
	.direct "c", "eeprom8000_bfff.eeData[address + 1] = 0 + cordicResultLow"
	goto nextPhi

storeResultInFourthEeprom:
	banksel cordicResult
	nop
	.direct "c", "eepromC000_ffff.eeData[address] = 0 + cordicResultHigh"
	.direct "c", "eepromC000_ffff.eeData[address + 1] = 0 + cordicResultLow"
	nop

nextPhi:
	nop
	.direct "c", "address = (address + 2) & 32767"
	incfsz phiLow
	goto testAct
	incfsz phiHigh
	goto testAct

testAssert:
	.assertTraceExternally
	return

	end
