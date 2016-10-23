	#ifndef __CLUCK2SESAME_INITIALISATIONCHAIN_INC
	#define __CLUCK2SESAME_INITIALISATIONCHAIN_INC

	#define INITIALISE_FIRST initialiseClock
	#define INITIALISE_AFTER_CLOCK initialiseTimer0
	#define INITIALISE_AFTER_TIMER0 initialiseSmps
	#define INITIALISE_AFTER_SMPS initialiseMotor
	#define INITIALISE_AFTER_MOTOR initialiseShiftRegister
	#define INITIALISE_AFTER_SHIFTREGISTER initialisationCompleted

	#endif