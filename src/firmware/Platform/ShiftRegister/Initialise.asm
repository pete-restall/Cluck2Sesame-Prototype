	#include "Platform.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"
	#include "ShiftRegister.inc"

	radix decimal

SHCP_PIN_ANSEL_MASK equ (1 << ANS4)
STCP_PIN_ANSEL_MASK equ (1 << ANS5)
DS_PIN_ANSEL_MASK equ (1 << ANS6)
ANSEL_DIGITAL_MASK equ SHCP_PIN_ANSEL_MASK | STCP_PIN_ANSEL_MASK | DS_PIN_ANSEL_MASK

	extern shiftRegisterBuffer
	extern INITIALISE_AFTER_SHIFTREGISTER

ShiftRegister code
	global initialiseShiftRegister

initialiseShiftRegister:
	.safelySetBankFor shiftRegisterBuffer
	clrf shiftRegisterBuffer

setPortModes:
	.setBankFor ANSEL
	movlw ~ANSEL_DIGITAL_MASK
	andwf ANSEL

clearDigitalOutputs:
	.setBankFor SHIFT_REGISTER_PORT
	movlw ~(SHCP_PIN_MASK | STCP_PIN_MASK | DS_PIN_MASK)
	andwf SHIFT_REGISTER_PORT

setPortDirections:
	.setBankFor SHIFT_REGISTER_TRIS
	movlw ~(SHCP_PIN_TRIS_MASK | STCP_PIN_TRIS_MASK | DS_PIN_TRIS_MASK)
	andwf SHIFT_REGISTER_TRIS

	tcall INITIALISE_AFTER_SHIFTREGISTER

	end
