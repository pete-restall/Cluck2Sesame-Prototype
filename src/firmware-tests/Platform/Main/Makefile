export SUT_OBJ_FILE=$(PLATFORM_DIR)/Main.o
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(PLATFORM_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/ShiftRegisterDummies.o

TEST_DOUBLE_OBJ_FILES=\
	ResetMocks.o \
	ResetDummies.o \
	PollMockToAssertTest.o \
	PollStubToAssertTest.o

all: $(TEST_DOUBLE_OBJ_FILES)
	$(MAKE) -C Reset all
	$(MAKE) -C Poll all
	$(MAKE) -C InitialisationCompleted all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Reset clean
	$(MAKE) -C Poll clean
	$(MAKE) -C InitialisationCompleted clean

include $(MAKEFILE_RULES)
