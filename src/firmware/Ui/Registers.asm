	#include "Platform.inc"

	radix decimal

UiRam udata
	global uiFlags
	global uiState
	global uiNextState

	global uiButtonEventBaseState
	global uiButtonReleasedTimestamp

	global uiOption1Position
	global uiOption2Position
	global uiOption3Position
	global uiSelectedOptionPosition
	global uiOptionCounter

	global uiBcdCount
	global uiBcdIncrement
	global uiBcdPointer
	global uiBcdPosition
	global uiBcdNextState

uiFlags res 1
uiState res 1
uiNextState res 1

uiButtonEventBaseState res 1
uiButtonReleasedTimestamp res 1

uiOption1Position res 1
uiOption2Position res 1
uiOption3Position res 1
uiSelectedOptionPosition res 1
uiOptionCounter res 1

uiBcdCount res 1
uiBcdIncrement res 1
uiBcdPointer res 1
uiBcdPosition res 1
uiBcdNextState res 1

	end
