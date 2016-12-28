	#include "Mcu.inc"
	#include "Cordic.inc"
	#include "States.inc"

	radix decimal

	defineCordicState CORDIC_STATE_SINECOSINEINITIALISE
clearUpperWordOfAllVectorComponents:
		banksel cordicXUpperHigh
		clrf cordicXUpperHigh
		clrf cordicXUpperLow

		clrf cordicYUpperHigh
		clrf cordicYUpperLow

		clrf cordicZUpperHigh
		clrf cordicZUpperLow

setInitialState:
		clrf cordicIterationNumber

		; TODO: MIGHT BE ABLE TO REMOVE THESE TWO LINES - TEST IT...
		btfsc cordicArgumentHigh, 7
		goto isArgumentLessThanNegativeNinetyDegrees

isArgumentGreaterThanNinetyDegrees:
		movf cordicArgumentLow, W
		sublw low(DEGREES_90)
		movf cordicArgumentHigh, W
		btfsc STATUS, C
		incfsz cordicArgumentHigh, W
		sublw high(DEGREES_90)

		btfss STATUS, C
		goto isArgumentLessThanNegativeNinetyDegrees

argumentIsGreaterThanNinetyDegrees:
clearX_1:
		clrf cordicXLowerHigh
		clrf cordicXLowerLow

setYToGainReciprocal:
		movlw high(GAIN_RECIPROCAL)
		movwf cordicYLowerHigh
		movlw low(GAIN_RECIPROCAL)
		movwf cordicYLowerLow

setZToNinetyDegrees:
		movlw high(DEGREES_90)
		movwf cordicZLowerHigh
		movlw low(DEGREES_90)
		movwf cordicZLowerLow

		goto calculateInitialError

isArgumentLessThanNegativeNinetyDegrees:
		movlw low(DEGREES_NEGATIVE90)
		subwf cordicArgumentLow, W
		movlw high(DEGREES_NEGATIVE90)

		#if low(high(DEGREES_NEGATIVE90) + 1) != 0
		btfsc STATUS, C
		movlw high(DEGREES_NEGATIVE90) + 1
		subwf cordicArgumentHigh, W
		#endif

		btfss STATUS, C
		goto setDefaultInitialState

argumentIsLessThanNegativeNinetyDegrees:
clearX_2:
		clrf cordicXLowerHigh
		clrf cordicXLowerLow

setYToNegativeGainReciprocal:
		comf cordicYUpperHigh
		comf cordicYUpperLow
		movlw high(-GAIN_RECIPROCAL)
		movwf cordicYLowerHigh
		movlw low(-GAIN_RECIPROCAL)
		movwf cordicYLowerLow

setZToNegativeNinetyDegrees:
		comf cordicZUpperHigh
		comf cordicZUpperLow
		movlw high(DEGREES_NEGATIVE90)
		movwf cordicZLowerHigh
		movlw low(DEGREES_NEGATIVE90)
		movwf cordicZLowerLow

		goto calculateInitialError

setDefaultInitialState:
setXToGainReciprocal:
		movlw high(GAIN_RECIPROCAL)
		movwf cordicXLowerHigh
		movlw low(GAIN_RECIPROCAL)
		movwf cordicXLowerLow

clearY:
		clrf cordicXLowerHigh
		clrf cordicXLowerLow

setZToZeroDegrees:
		clrf cordicZLowerHigh
		clrf cordicZLowerLow

calculateInitialError:
		setCordicState CORDIC_STATE_CALCULATEERRORFROMZ
		setCordicNextState CORDIC_STATE_ITERATION
		returnFromCordicState

	end
