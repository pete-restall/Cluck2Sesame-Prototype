export SUT_OBJ_FILE=$(PLATFORM_DIR)/Clock.a
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(PLATFORM_CORE_OBJ_FILES) \
	$(PLATFORM_DIR)/Arithmetic4.o \
	$(PLATFORM_DIR)/ArithmeticBcd.a \
	$(PLATFORM_DIR)/Flash.o \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(CURDIR)/InitialiseAfterClockMock.o \
	$(CURDIR)/../Isr/InitialiseAfterIsrDummy.o

TEST_DOUBLE_OBJ_FILES=\
	InitialiseAfterClockMock.o \
	PollAfterClockDummy.o \
	PollAfterClockMock.o \
	ClockDummies.o \
	ClockStubs.o

all: $(TEST_DOUBLE_OBJ_FILES)
	$(MAKE) -C Initialisation all
	$(MAKE) -C TimerWiring all
	$(MAKE) -C Poll all
	$(MAKE) -C DayOfYear all
	$(MAKE) -C DaylightSavings all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Initialisation clean
	$(MAKE) -C TimerWiring clean
	$(MAKE) -C Poll clean
	$(MAKE) -C DayOfYear clean
	$(MAKE) -C DaylightSavings clean

include $(MAKEFILE_RULES)
