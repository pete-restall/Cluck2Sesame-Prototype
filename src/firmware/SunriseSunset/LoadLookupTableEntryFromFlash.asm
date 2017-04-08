	#define __CLUCK2SESAME_SUNRISESUNSET_LOADLOOKUPTABLEENTRYFROMFLASH_ASM

	#include "Platform.inc"
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

	.setBankFor EEADR
	incf EEADR
	.setBankFor EEADRH
	btfsc STATUS, Z
	incf EEADRH
	fcall readFlashWord

storeIntoIndf:
	.safelySetBankFor EEDATH
	movf EEDATH, W
	movwf INDF
	incf FSR
	.setBankFor EEDAT
	movf EEDAT, W
	movwf INDF
	incf FSR

	return

	end
