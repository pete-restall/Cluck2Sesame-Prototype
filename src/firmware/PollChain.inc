	#ifndef __CLUCK2SESAME_POLLCHAIN_INC
	#define __CLUCK2SESAME_POLLCHAIN_INC

	extern pollTemperatureSensor
	extern pollClock
	extern pollChain

	#define POLL_FIRST pollTemperatureSensor
	#define POLL_AFTER_TEMPERATURE_SENSOR pollClock
	#define POLL_AFTER_CLOCK pollSleep

	#endif
