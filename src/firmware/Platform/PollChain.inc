	#ifndef __CLUCK2SESAME_PLATFORM_POLLCHAIN_INC
	#define __CLUCK2SESAME_PLATFORM_POLLCHAIN_INC

	#define POLL_FIRST pollSmps
	#define POLL_AFTER_SMPS pollTemperatureSensor
	#define POLL_AFTER_TEMPERATURESENSOR pollClock
	#define POLL_AFTER_CLOCK pollMotor
	#define POLL_AFTER_MOTOR pollLcd
	#define POLL_AFTER_LCD pollUi
	#define POLL_AFTER_UI pollSunriseSunset
	#define POLL_AFTER_SUNRISESUNSET pollDoor
	#define POLL_AFTER_DOOR pollPowerManagement

	#endif
