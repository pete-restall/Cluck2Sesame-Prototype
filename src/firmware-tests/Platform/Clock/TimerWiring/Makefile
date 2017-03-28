HEX_FILES=\
	Timer1OverflowIncrementsTimeTest.hex \
	IsrDoesNotIncrementTimeTest.hex \
	IsrWithNonClockTickTest.hex

OBJ_FILES+=\
	$(PLATFORM_DIR)/Isr.o \
	$(PLATFORM_DIR)/Arithmetic32.a \
	../../ResetFlagsStubs.o \
	../../PowerManagementDummies.o \
	../../Lcd/LcdContrastDummies.o \
	../../Motor/MotorDummies.o

TIMER1_OVERFLOW_INCREMENTS_TIME_OBJ_FILES=\
	Timer1OverflowIncrementsTimeTest.o

ISR_DOES_NOT_INCREMENT_TIME_OBJ_FILES=\
	IsrDoesNotIncrementTimeTest.o

ISR_WITH_NON_CLOCK_TICK_OBJ_FILES=\
	IsrWithNonClockTickTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

Timer1OverflowIncrementsTimeTest.hex: $(OBJ_FILES) $(TIMER1_OVERFLOW_INCREMENTS_TIME_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(TIMER1_OVERFLOW_INCREMENTS_TIME_OBJ_FILES)

IsrDoesNotIncrementTimeTest.hex: $(OBJ_FILES) $(ISR_DOES_NOT_INCREMENT_TIME_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ISR_DOES_NOT_INCREMENT_TIME_OBJ_FILES)

IsrWithNonClockTickTest.hex: $(OBJ_FILES) $(ISR_WITH_NON_CLOCK_TICK_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ISR_WITH_NON_CLOCK_TICK_OBJ_FILES)

include $(MAKEFILE_RULES)
