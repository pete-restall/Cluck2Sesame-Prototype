export SUT_OBJ_FILE=$(FIRMWARE_DIR)/BrownOutReset.o
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(FIRMWARE_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(ASSERT_NO_ISR_OBJ_FILE)

all:
	$(MAKE) -C Pcon all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Pcon clean

include $(MAKEFILE_RULES)
