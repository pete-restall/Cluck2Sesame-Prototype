export SUT_OBJ_FILE=$(FIRMWARE_DIR)/PowerManagement.a
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(FIRMWARE_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(ASSERT_NO_ISR_OBJ_FILE) \
	$(CURDIR)/InitialiseAfterPowerManagementMock.o

TEST_DOUBLE_OBJ_FILES=\
	InitialiseAfterPowerManagementMock.o

all:
	$(MAKE) -C Initialisation all
	$(MAKE) -C Poll all
	$(MAKE) -C ClockSwitching all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Initialisation clean
	$(MAKE) -C Poll clean
	$(MAKE) -C ClockSwitching clean

include $(MAKEFILE_RULES)
