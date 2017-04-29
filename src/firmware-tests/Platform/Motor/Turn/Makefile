ASARGS+=-I$(PLATFORM_DIR)/Motor

HEX_FILES=\
	TurningThenStoppedTest.hex

TURNING_THEN_STOPPED_OBJ_FILES=\
	TurningThenStoppedTest.o \
	../PollAfterMotorDummy.o \
	$(PLATFORM_TESTS_DIR)/Smps/SmpsDummies.o \
	$(PLATFORM_TESTS_DIR)/Adc/AdcDummies.o

TEST_FIXTURE_OBJ_FILES=\
	PwmDutyCycleFromRestTestFixture.o \
	PwmDutyCycleForReverseTestFixture.o \
	SetAdcChannelFromRestIsSuccessfulTestFixture.o \
	PreConditionsFromRestAreUnsuccessfulTestFixture.o

all: $(TEST_FIXTURE_OBJ_FILES) $(HEX_FILES)
	$(MAKE) -C Clockwise all
	$(MAKE) -C AntiClockwise all
	$(MAKE) -C Stop all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Clockwise clean
	$(MAKE) -C AntiClockwise clean
	$(MAKE) -C Stop clean

TurningThenStoppedTest.hex: $(OBJ_FILES) $(TURNING_THEN_STOPPED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(TURNING_THEN_STOPPED_OBJ_FILES)


include $(MAKEFILE_RULES)
