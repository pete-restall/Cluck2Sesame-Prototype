	#define __CLUCK2SESAME_SUNRISESUNSET_LOADLOOKUPTABLEENTRYFROMFLASH_ASM

	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Flash.inc"
	#include "Arithmetic32.inc"
	#include "SunriseSunset.inc"

	radix decimal

SunriseSunset code
	global loadLookupTableEntryFromFlash

loadLookupTableEntryFromFlash:
	setupIndf lookupEntry
	fcall readFlashWord
	call storeIntoIndf

	banksel EEADR
	incf EEADR
	banksel EEADRH
	btfsc STATUS, Z
	incf EEADRH
	fcall readFlashWord

storeIntoIndf:
	banksel EEDATH
	movf EEDATH, W
	movwf INDF
	incf FSR
	banksel EEDAT
	movf EEDAT, W
	movwf INDF
	incf FSR

	return

	end
