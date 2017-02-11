	#define __CLUCK2SESAME_SUNRISESUNSET_REGISTERLOADANDANDSTORE_ASM

	#include "Mcu.inc"
	#include "SunriseSunset.inc"
	#include "../Platform/Arithmetic32.inc"

	radix decimal

SunriseSunset code
	global loadCoefficientIntoAccumulator
	global loadCoefficientIntoLowerA
	global loadCoefficientIntoUpperB
	global loadDayOfYearFractionalIntoLowerB
	global loadAccumulatorIntoA
	global loadCurveFitAccumulatorIntoB
	global loadCurveFitAccumulatorLowerIntoLowerB
	global storeAShiftedRight15IntoCurveFitAccumulator
	global storeAIntoAccumulator
	global storeAIntoCurveFitAccumulator

loadCoefficientIntoAccumulator:
	banksel accumulator
	movf coefficientHigh, W
	movwf accumulatorLowerHigh
	movf coefficientLow, W
	movwf accumulatorLowerLow

signExtendCoefficientIntoAccumulator:
	clrw
	btfsc coefficientHigh, 7
	movlw 0xff
	movwf accumulatorUpperHigh
	movwf accumulatorUpperLow
	return

loadCoefficientIntoLowerA:
	banksel coefficientHigh
	movf coefficientHigh, W
	banksel RAC
	movwf RAC

	banksel coefficientLow
	movf coefficientLow, W
	banksel RAD
	movwf RAD
	return

loadCoefficientIntoUpperB:
	banksel coefficientHigh
	movf coefficientHigh, W
	banksel RBA
	movwf RBA

	banksel coefficientLow
	movf coefficientLow, W
	banksel RBB
	movwf RBB
	return

loadDayOfYearFractionalIntoLowerB:
	banksel dayOfYearFractionalHigh
	movf dayOfYearFractionalHigh, W
	banksel RBC
	movwf RBC

	banksel dayOfYearFractionalLow
	movf dayOfYearFractionalLow, W
	banksel RBD
	movwf RBD
	return

loadAccumulatorIntoA:
	setupIndf accumulator

loadIntoA:
	loadFromIndf32Into RAA
	return

loadCurveFitAccumulatorIntoB:
	setupIndf curveFitAccumulator

loadIntoB:
	loadFromIndf32Into RBA
	return

loadCurveFitAccumulatorLowerIntoLowerB:
	banksel curveFitAccumulatorLowerHigh
	movf curveFitAccumulatorLowerHigh, W
	banksel RBC
	movwf RBC
	banksel curveFitAccumulatorLowerLow
	movf curveFitAccumulatorLowerLow, W
	banksel RBD
	movwf RBD
	return

storeAShiftedRight15IntoCurveFitAccumulator:
	banksel RAC
	rlf RAC, W
	rlf RAB, W
	banksel curveFitAccumulatorLowerLow
	movwf curveFitAccumulatorLowerLow
	banksel RAA
	rlf RAA, W
	banksel curveFitAccumulatorLowerHigh
	movwf curveFitAccumulatorLowerHigh
; TODO: IS THE SIGN EXTEND NECESSARY ?  START TEMPORARY...
	clrf curveFitAccumulatorUpperHigh
	clrf curveFitAccumulatorUpperLow
	return
; TODO: IS THE SIGN EXTEND NECESSARY ?  END TEMPORARY...

signExtendMostSignificantBitOfRAAIntoUpper:
	clrw
	btfsc STATUS, C
	movlw 0xff
	movwf curveFitAccumulatorUpperHigh
	movwf curveFitAccumulatorUpperLow
	return

storeAIntoAccumulator:
	setupIndf accumulator

storeFromA:
	storeIntoIndf32From RAA
	return

storeAIntoCurveFitAccumulator:
	setupIndf curveFitAccumulator
	goto storeFromA

	end
