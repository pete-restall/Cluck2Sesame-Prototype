export SUT_OBJ_FILE=$(PLATFORM_DIR)/PowerManagement.a
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(PLATFORM_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(ASSERT_NO_ISR_OBJ_FILE) \
	$(PLATFORM_DIR)/Timer0.a \
	$(PLATFORM_TESTS_DIR)/Timer0/PollAfterTimer0Dummy.o \
	$(CURDIR)/InitialiseAfterPowerManagementMock.o

TEST_DOUBLE_OBJ_FILES=\
	InitialiseAfterPowerManagementMock.o \
	InitialiseAfterPowerManagementDummy.o \
	PollAfterPowerManagementDummy.o \
	PowerManagementDummies.o \
	PowerManagementMocks.o

all: $(TEST_DOUBLE_OBJ_FILES)
	$(MAKE) -C Initialisation all
	$(MAKE) -C Poll all
	$(MAKE) -C ClockSwitching all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Initialisation clean
	$(MAKE) -C Poll clean
	$(MAKE) -C ClockSwitching clean

include $(MAKEFILE_RULES)
