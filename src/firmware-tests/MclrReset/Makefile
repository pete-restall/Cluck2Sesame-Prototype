export SUT_OBJ_FILE=$(FIRMWARE_DIR)/MclrReset.o
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(FIRMWARE_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(ASSERT_NO_ISR_OBJ_FILE)

all:
	$(MAKE) -C Pcon all
	$(MAKE) -C Initialisation all
	$(MAKE) -C ResetFlags all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Pcon clean
	$(MAKE) -C Initialisation clean
	$(MAKE) -C ResetFlags clean

include $(MAKEFILE_RULES)
