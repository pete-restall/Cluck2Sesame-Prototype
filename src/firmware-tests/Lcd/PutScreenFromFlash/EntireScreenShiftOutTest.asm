	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Timer0.inc"
	#include "Lcd.inc"
	#include "Flash.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global initialShiftRegisterBuffer
	global shiftRegisterBuffer

initialShiftRegisterBuffer res 1
shiftRegisterBuffer res 1
logShiftOutBuffer res 1
shiftOutEepromCounter res 1

EntireScreenShiftOutTest code
	global testArrange
	global shiftOut

testArrange:
	banksel logShiftOutBuffer
	clrf logShiftOutBuffer
	clrf shiftOutEepromCounter

	fcall initialiseTimer0
	fcall initialiseLcd
	fcall enableLcd

waitUntilLcdIsEnabled:
	fcall pollLcd
	fcall isLcdEnabled
	xorlw 0
	btfsc STATUS, Z
	goto waitUntilLcdIsEnabled

	banksel initialShiftRegisterBuffer
	movf initialShiftRegisterBuffer, W
	banksel shiftRegisterBuffer
	movwf shiftRegisterBuffer

testAct:
	banksel logShiftOutBuffer
	comf logShiftOutBuffer

	loadFlashAddressOf lcdScreen
	fcall putScreenFromFlash

waitUntilLcdIsIdle:
	fcall pollLcd
	fcall isLcdIdle
	xorlw 0
	btfsc STATUS, Z
	goto waitUntilLcdIsIdle

testAssert:
	.assertTraceExternally
	return

lcdScreen:
lcdScreenLine1 da "This is a simple"
lcdScreenLine2 da "LCD screen test."

shiftOut:
	banksel logShiftOutBuffer
	movf logShiftOutBuffer
	btfsc STATUS, Z
	return

writeShiftRegisterBufferToNextEepromAddress:
	banksel shiftOutEepromCounter
	movf shiftOutEepromCounter, W
	incf shiftOutEepromCounter
	banksel EEADR
	movwf EEADR
	clrf EEADRH

	banksel shiftRegisterBuffer
	movf shiftRegisterBuffer, W
	banksel EEDAT
	movwf EEDAT

	banksel PIR2
	bcf PIR2, EEIF

runEepromMagicSequenceToCommitWrite:
	banksel EECON1
	bcf EECON1, EEPGD
	bsf EECON1, WREN
	movlw 0x55
	movwf EECON2
	movlw 0xaa
	movwf EECON2
	bsf EECON1, WR

waitForEepromWriteToComplete:
	banksel PIR2
	btfss PIR2, EEIF
	goto waitForEepromWriteToComplete
	return

	end
