HEX_FILES=\
	PollChainTest.hex

POLL_CHAIN_OBJ_FILES=\
	PollChainTest.o \
	../InitialiseAfterUiDummy.o \
	../PollAfterUiMock.o \
	$(FIRMWARE_TESTS_DIR)/Door/DoorDummies.o \
	$(FIRMWARE_TESTS_DIR)/SunriseSunset/SunriseSunsetNonInitialiseAndPollDummies.o \
	$(PLATFORM_TESTS_DIR)/Timer0/Timer0Dummies.o \
	$(PLATFORM_TESTS_DIR)/PowerManagement/PowerManagementDummies.o \
	$(PLATFORM_TESTS_DIR)/Lcd/LcdDummies.o \
	$(PLATFORM_TESTS_DIR)/Buttons/ButtonsDummies.o \
	$(PLATFORM_TESTS_DIR)/Motor/MotorDummies.o \
	$(PLATFORM_TESTS_DIR)/Smps/SmpsDummies.o \
	$(PLATFORM_TESTS_DIR)/Clock/ClockDummies.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

PollChainTest.hex: $(OBJ_FILES) $(POLL_CHAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(POLL_CHAIN_OBJ_FILES)

include $(MAKEFILE_RULES)
