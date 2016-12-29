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

		btfsc cordicArgumentHigh, 7
		goto isArgumentLessThanNegativeNinetyDegrees

isArgumentGreaterThanNinetyDegrees:
		movf cordicArgumentLow, W
		sublw low(DEGREES_90)
		movf cordicArgumentHigh, W
		btfss STATUS, C
		incfsz cordicArgumentHigh, W
		sublw high(DEGREES_90)

		btfsc STATUS, C
		goto setDefaultInitialState

argumentIsGreaterThanNinetyDegrees:
 nop
 .direct "c", "echo ********* GREATER THAN 90 DEGREES"
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
		btfss cordicArgumentHigh, 7
		goto setDefaultInitialState

		movlw low(DEGREES_NEGATIVE90)
		subwf cordicArgumentLow, W
		movlw high(DEGREES_NEGATIVE90)

		#if low(high(DEGREES_NEGATIVE90) + 1) != 0
		btfss STATUS, C
		movlw low(high(DEGREES_NEGATIVE90) + 1)
		subwf cordicArgumentHigh, W
		#else
		btfsc STATUS, C
		subwf cordicArgumentHigh, W
		#endif

		btfsc STATUS, C
		goto setDefaultInitialState

argumentIsLessThanNegativeNinetyDegrees:
 nop
 .direct "c", "echo ********* LESS THAN -90 DEGREES"
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
 nop
 .direct "c", "echo ********* DEFAULT INITIAL STATE"
setXToGainReciprocal:
		movlw high(GAIN_RECIPROCAL)
		movwf cordicXLowerHigh
		movlw low(GAIN_RECIPROCAL)
		movwf cordicXLowerLow

clearY:
		clrf cordicYLowerHigh
		clrf cordicYLowerLow

setZToZeroDegrees:
		clrf cordicZLowerHigh
		clrf cordicZLowerLow

calculateInitialError:
		setCordicState CORDIC_STATE_CALCULATEERRORFROMZ
		returnFromCordicState

	end
