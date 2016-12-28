	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Arithmetic32.inc"
	#include "Cordic.inc"
	#include "States.inc"

	radix decimal

	defineCordicState CORDIC_STATE_CALCULATEERRORFROMZ
		call loadCordicZIntoB
		fcall negateB32
		call loadCordicArgumentIntoA
		fcall add32
		call storeCordicErrorFromA

		moveToNextCordicState
		returnFromCordicState

	defineCordicStateInSameSection CORDIC_STATE_CALCULATEERRORFROMY
		returnFromCordicState

	end
