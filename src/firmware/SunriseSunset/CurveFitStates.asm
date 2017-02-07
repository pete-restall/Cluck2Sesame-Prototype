	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "../Platform/Arithmetic16.inc"
	#include "../Platform/Arithmetic32.inc"
	#include "../Platform/Cordic.inc"
	#include "SunriseSunset.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_CURVEFIT1
		call loadNextCoefficient
		call loadCoefficientIntoUpperB
		call loadDayOfYearFractionalIntoLowerB
		fcall mul16x16
		call storeAShiftedRight15IntoCurveFitAccumulator
		setSunriseSunsetState SUN_STATE_CURVEFIT2
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_CURVEFIT2
shiftTwoLeastSignificantBitsIntoUpperB:
		banksel extendedCoefficients
		movf extendedCoefficients, W
		andlw b'00000011'
		rrf extendedCoefficients
		rrf extendedCoefficients

		banksel RBB
		movwf RBB
		clrf RBA

multiplyDayOfYearFractionalByExtendedCoefficient:
		call loadDayOfYearFractionalIntoLowerB
		fcall mul16x16

addToCurveFitAccumulator:
		call loadCurveFitAccumulatorIntoB
		fcall add32
		call storeAIntoCurveFitAccumulator

		setSunriseSunsetState SUN_STATE_CURVEFIT3
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_CURVEFIT3
		call loadNextCoefficient

		banksel RAA
		clrf RAA
		clrf RAB
		call loadCoefficientIntoLowerA

		call loadCurveFitAccumulatorIntoB
		fcall add32
		call storeAIntoCurveFitAccumulator

		setSunriseSunsetState SUN_STATE_CURVEFIT4
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_CURVEFIT4
		; TODO: IF CORDIC IS BUSY, DO NOT CHANGE STATE...(CALL isCordicIdle)
		; AND BEFORE loadSineArgument OTHERWISE YOU TROUNCE THE VALUE THAT
		; THE CURRENT CALCULATION IS USING

		loadSineArgument curveFitAccumulatorLower
		fcall sine
		setSunriseSunsetState SUN_STATE_CURVEFIT5
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_CURVEFIT5
		fcall isCordicIdle
		xorlw 0
		btfsc STATUS, Z
		goto endOfState

storeSineResultInAccumulator:
		banksel cordicResultHigh
		movf cordicResultHigh, W
		banksel curveFitAccumulatorLowerHigh
		movwf curveFitAccumulatorLowerHigh
		banksel cordicResultLow
		movf cordicResultLow, W
		banksel curveFitAccumulatorLowerLow
		movwf curveFitAccumulatorLowerLow

nextCoefficientAndNextState:
		call loadNextCoefficient
		setSunriseSunsetState SUN_STATE_CURVEFIT6

endOfState:
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_CURVEFIT6
		call loadCoefficientIntoUpperB
		call loadCurveFitAccumulatorLowerIntoLowerB
		fcall mul16x16
		call storeAShiftedRight15IntoCurveFitAccumulator
		setSunriseSunsetState SUN_STATE_CURVEFIT7
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_CURVEFIT7
accumulateResultOfIteration:
		call loadAccumulatorIntoA
		call loadCurveFitAccumulatorIntoB
		fcall add32
		call storeAIntoAccumulator

checkIfAnotherIterationIsRequired:
		banksel numberOfCurveFittingIterations
		decfsz numberOfCurveFittingIterations
		goto startAnotherIteration

noMoreIterations:
		banksel sunriseSunsetNextState
		movf sunriseSunsetNextState, W
		movwf sunriseSunsetState
		returnFromSunriseSunsetState

startAnotherIteration:
		setSunriseSunsetState SUN_STATE_CURVEFIT1
		returnFromSunriseSunsetState

	end
