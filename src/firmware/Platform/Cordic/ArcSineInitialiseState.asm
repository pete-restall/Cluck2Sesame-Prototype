	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Arithmetic16.inc"
	#include "Arithmetic32.inc"
	#include "Cordic.inc"
	#include "States.inc"

	radix decimal

ONE_Q2_30_UPPER_HIGH equ 0x40

	defineCordicState CORDIC_STATE_ARCSINEINITIALISE
squareCordicArgumentAndStoreIntoZ:
loadArgumentIntoAccumulatorB:
		movf cordicArgumentHigh, W
		banksel RBA
		movwf RBA
		movwf RBC
		banksel cordicArgumentLow
		movf cordicArgumentLow, W
		banksel RBB
		movwf RBB
		movwf RBD
		btfss RBA, 7
		goto multiplyAndStoreInZ

twosComplementOnAccumulatorForNegativeArgument:
		comf RBA
		comf RBB
		incfsz RBB
		goto $ + 2
		incf RBA

		comf RBC
		comf RBD
		incfsz RBD
		goto $ + 2
		incf RBC

multiplyAndStoreInZ:
		fcall mul16x16
		call storeAIntoCordicZ

		setCordicState CORDIC_STATE_ARCSINEINITIALISE2
		returnFromCordicState


	defineCordicStateInSameSection CORDIC_STATE_ARCSINEINITIALISE2
oneTakeZSquaredAsQ2_30:
		banksel RAA
		movlw ONE_Q2_30_UPPER_HIGH
		movwf RAA
		clrf RAB
		clrf RAC
		clrf RAD

		call loadCordicZIntoB
		fcall negateB32
		fcall add32
		call storeAIntoCordicX

		setCordicState CORDIC_STATE_ARCSINEINITIALISE3
		returnFromCordicState


	defineCordicStateInSameSection CORDIC_STATE_ARCSINEINITIALISE3
roundXAsQ2_30ToQ0_16:
		call loadCordicXIntoCordicW

		banksel cordicIterationNumber
		movlw 14
		movwf cordicIterationNumber

		call shiftCordicWByIterationNumber

checkIfBit13Set:
		banksel cordicXLowerHigh
		btfss cordicXLowerHigh, 5
		goto calculateSquareRootOfOneTakeXSquared

roundUp:
		incfsz cordicWLowerLow
		goto calculateSquareRootOfOneTakeXSquared
		incf cordicWLowerHigh

calculateSquareRootOfOneTakeXSquared:
		clrf cordicWUpperHigh
		clrf cordicWUpperLow

		setCordicState CORDIC_STATE_SQRTINITIALISE
		returnFromCordicState

	end
