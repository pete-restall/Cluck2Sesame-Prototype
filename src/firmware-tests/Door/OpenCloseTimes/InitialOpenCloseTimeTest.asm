	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Door.inc"
	#include "../DoorStates.inc"
	#include "Clock.inc"
	#include "SunriseSunset.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global initialLatitudeOffset
	global initialLongitudeOffset
	global expectDoorIsOpen
	global expectDoorIsClosed

initialLatitudeOffset res 1
initialLongitudeOffset res 1
expectDoorIsOpen res 1
expectDoorIsClosed res 1

InitialOpenCloseTimeTest code
	global testArrange

testArrange:
	fcall initialiseSunriseSunset
	fcall initialiseDoor
	fcall doorSettingsAreComplete

	banksel initialLatitudeOffset
	movf initialLatitudeOffset, W
	banksel latitudeOffset
	movwf latitudeOffset

	banksel initialLongitudeOffset
	movf initialLongitudeOffset, W
	banksel longitudeOffset
	movwf longitudeOffset

testAct:
	fcall pollSunriseSunset
	fcall pollDoor

	banksel doorState
	movlw DOOR_STATE_OPEN
	xorwf doorState, W
	btfsc STATUS, Z
	goto testAssertDoorShouldBeOpen

	movlw DOOR_STATE_CLOSE
	xorwf doorState, W
	btfsc STATUS, Z
	goto testAssertDoorShouldBeClosed

	goto testAct

testAssertDoorShouldBeOpen:
	banksel expectDoorIsOpen
	movf expectDoorIsOpen
	movlw 0
	btfss STATUS, Z
	movlw 1
	.assert "W != 0, 'Door is open, but expected it to be closed.'"
	return

testAssertDoorShouldBeClosed:
	banksel expectDoorIsClosed
	movf expectDoorIsClosed
	movlw 0
	btfss STATUS, Z
	movlw 1
	.assert "W != 0, 'Door is closed, but expected it to be open.'"
	return

	end
