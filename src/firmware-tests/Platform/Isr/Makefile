export SUT_OBJ_FILE=$(PLATFORM_DIR)/Isr.o
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(PLATFORM_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(PLATFORM_DIR)/PowerManagement.a \
	$(PLATFORM_TESTS_DIR)/Timer0/Timer0Dummies.o \
	$(PLATFORM_TESTS_DIR)/Lcd/LcdContrastDummies.o \
	$(PLATFORM_TESTS_DIR)/Motor/MotorDummies.o \
	$(PLATFORM_TESTS_DIR)/Clock/ClockDummies.o

TEST_DOUBLE_OBJ_FILES=\
	InitialiseAfterIsrDummy.o \
	InitialiseAfterIsrMock.o

all: $(TEST_DOUBLE_OBJ_FILES)
	$(MAKE) -C Initialisation all
	$(MAKE) -C PreventSleep all
	$(MAKE) -C Motor all
	$(MAKE) -C ButtonChange all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Initialisation clean
	$(MAKE) -C PreventSleep clean
	$(MAKE) -C Motor clean
	$(MAKE) -C ButtonChange clean

include $(MAKEFILE_RULES)
