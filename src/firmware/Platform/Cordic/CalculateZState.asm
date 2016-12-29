	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Flash.inc"
	#include "Arithmetic32.inc"
	#include "Cordic.inc"
	#include "States.inc"

	radix decimal

	defineCordicState CORDIC_STATE_CALCULATEZ
loadArcTangentForCurrentIteration:
		banksel cordicIterationNumber
		movlw low(arcTangentLookup)
		addwf cordicIterationNumber, W
		banksel EEADR
		movwf EEADR
		banksel EEADRH
		movlw high(arcTangentLookup)
		movwf EEADRH
		btfsc STATUS, C
		incf EEADRH

		fcall readFlashWord

loadArcTangentIntoAccumulatorB:
		banksel EEDAT
		movf EEDAT, W
		banksel RBD
		movwf RBD
		banksel EEDATH
		movf EEDATH, W
		banksel RBC
		movwf RBC
		fcall signExtendToUpperWordB32

loadZIntoAccumulatorA:
		call loadCordicZIntoA
		btfsc cordicFlags, CORDIC_FLAG_ERRORPOSITIVE
		goto addAccumulatorsAndStore
		fcall negateB32

addAccumulatorsAndStore:
		fcall add32
		call storeAIntoCordicZ

		setCordicState CORDIC_STATE_ENDOFITERATION
		returnFromCordicState

	end
