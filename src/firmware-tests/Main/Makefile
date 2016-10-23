export SUT_OBJ_FILE=$(FIRMWARE_DIR)/Main.o
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(FIRMWARE_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES)

all: ResetMocks.o ResetDummies.o PollMockToAssertTest.o PollStubToAssertTest.o
	$(MAKE) -C Reset all
	$(MAKE) -C Poll all
	$(MAKE) -C InitialisationCompleted all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Reset clean
	$(MAKE) -C Poll clean
	$(MAKE) -C InitialisationCompleted clean

include $(MAKEFILE_RULES)
