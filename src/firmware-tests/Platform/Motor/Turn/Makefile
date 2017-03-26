TEST_FIXTURE_OBJ_FILES=\
	PwmDutyCycleFromRestTest.o

all: $(TEST_FIXTURE_OBJ_FILES)
	$(MAKE) -C Clockwise all
	$(MAKE) -C AntiClockwise all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Clockwise clean
	$(MAKE) -C AntiClockwise clean

include $(MAKEFILE_RULES)
