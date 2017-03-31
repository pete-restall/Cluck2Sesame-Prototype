TEST_FIXTURE_OBJ_FILES=\
	PwmDutyCycleFromRestTestFixture.o \
	PwmDutyCycleForReverseTestFixture.o \
	SetAdcChannelFromRestIsSuccessfulTestFixture.o \
	SetAdcChannelFromRestIsUnsuccessfulTestFixture.o

all: $(TEST_FIXTURE_OBJ_FILES)
	$(MAKE) -C Clockwise all
	$(MAKE) -C AntiClockwise all
	$(MAKE) -C Stop all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Clockwise clean
	$(MAKE) -C AntiClockwise clean
	$(MAKE) -C Stop clean

include $(MAKEFILE_RULES)
