export SUT_OBJ_FILE=$(PLATFORM_DIR)/Isr.o
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(PLATFORM_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(CURDIR)/../Lcd/LcdContrastDummies.o \
	$(CURDIR)/../PowerManagementDummies.o \
	$(CURDIR)/../Motor/MotorDummies.o

TEST_DOUBLE_OBJ_FILES=\
	InitialiseAfterIsrDummy.o \
	InitialiseAfterIsrMock.o \
	ClockDummies.o

all: $(TEST_DOUBLE_OBJ_FILES)
	$(MAKE) -C Initialisation all
	$(MAKE) -C PreventSleep all
	$(MAKE) -C Motor all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Initialisation clean
	$(MAKE) -C PreventSleep clean
	$(MAKE) -C Motor clean

include $(MAKEFILE_RULES)
