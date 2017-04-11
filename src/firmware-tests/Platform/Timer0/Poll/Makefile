HEX_FILES=\
	PollChainTest.hex \
	OverflowIncrementsSlowTimerTest.hex \
	OverflowWithoutT0IfDoesNotIncrementSlowTimerTest.hex

POLL_CHAIN_OBJ_FILES=\
	PollChainTest.o \
	../InitialiseAfterTimer0Dummy.o \
	../PollAfterTimer0Mock.o

OVERFLOW_INCREMENTS_SLOW_TIMER_OBJ_FILES=\
	OverflowIncrementsSlowTimerTest.o \
	../InitialiseAfterTimer0Dummy.o \
	../PollAfterTimer0Dummy.o

OVERFLOW_WITHOUT_T0IF_DOES_NOT_INCREMENT_SLOW_TIMER_OBJ_FILES=\
	OverflowWithoutT0IfDoesNotIncrementSlowTimerTest.o \
	../InitialiseAfterTimer0Dummy.o \
	../PollAfterTimer0Dummy.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

PollChainTest.hex: $(OBJ_FILES) $(POLL_CHAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(POLL_CHAIN_OBJ_FILES)

OverflowIncrementsSlowTimerTest.hex: $(OBJ_FILES) $(OVERFLOW_INCREMENTS_SLOW_TIMER_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(OVERFLOW_INCREMENTS_SLOW_TIMER_OBJ_FILES)

OverflowWithoutT0IfDoesNotIncrementSlowTimerTest.hex: $(OBJ_FILES) $(OVERFLOW_WITHOUT_T0IF_DOES_NOT_INCREMENT_SLOW_TIMER_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(OVERFLOW_WITHOUT_T0IF_DOES_NOT_INCREMENT_SLOW_TIMER_OBJ_FILES)

include $(MAKEFILE_RULES)
