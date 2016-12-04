	#ifndef __CLUCK2SESAME_FARCALLS_INC
	#define __CLUCK2SESAME_FARCALLS_INC

fcall macro destination
	local nextInstruction
	pagesel destination
	call destination
	pagesel nextInstruction
nextInstruction:
	endm

fgoto macro destination
	pagesel destination
	goto destination
	endm

	#endif
