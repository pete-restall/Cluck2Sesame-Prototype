ASARGS+=-I $(FIRMWARE_DIR)/Ui

HEX_FILES=\
	InitialisationChainTest.hex \
	InitialStateTest.hex

TEST_DOUBLE_OBJ_FILES=\
	../PollAfterUiDummy.o \
	$(FIRMWARE_TESTS_DIR)/Door/DoorDummies.o \
	$(FIRMWARE_TESTS_DIR)/SunriseSunset/SunriseSunsetNonInitialiseAndPollDummies.o \
	$(PLATFORM_TESTS_DIR)/Timer0/Timer0Dummies.o \
	$(PLATFORM_TESTS_DIR)/PowerManagement/PowerManagementDummies.o \
	$(PLATFORM_TESTS_DIR)/Lcd/LcdDummies.o \
	$(PLATFORM_TESTS_DIR)/Buttons/ButtonsDummies.o \
	$(PLATFORM_TESTS_DIR)/Motor/MotorDummies.o \
	$(PLATFORM_TESTS_DIR)/Smps/SmpsDummies.o \
	$(PLATFORM_TESTS_DIR)/Clock/ClockDummies.o

INITIALISATION_CHAIN_OBJ_FILES=\
	InitialisationChainTest.o \
	../InitialiseAfterUiMock.o \
	$(TEST_DOUBLE_OBJ_FILES)

INITIAL_STATE_OBJ_FILES=\
	InitialStateTest.o \
	../InitialiseAfterUiDummy.o \
	$(TEST_DOUBLE_OBJ_FILES)

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

InitialisationChainTest.hex: $(OBJ_FILES) $(INITIALISATION_CHAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(INITIALISATION_CHAIN_OBJ_FILES)

InitialStateTest.hex: $(OBJ_FILES) $(INITIAL_STATE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(INITIAL_STATE_OBJ_FILES)

include $(MAKEFILE_RULES)
