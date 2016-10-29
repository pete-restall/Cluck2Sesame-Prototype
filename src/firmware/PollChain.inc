	#ifndef __CLUCK2SESAME_POLLCHAIN_INC
	#define __CLUCK2SESAME_POLLCHAIN_INC

	#define POLL_FIRST pollSmps
	#define POLL_AFTER_SMPS pollTemperatureSensor
	#define POLL_AFTER_TEMPERATURESENSOR pollClock
	#define POLL_AFTER_CLOCK pollMotor
	#define POLL_AFTER_MOTOR pollLcd
	#define POLL_AFTER_LCD pollSleep

	#endif
