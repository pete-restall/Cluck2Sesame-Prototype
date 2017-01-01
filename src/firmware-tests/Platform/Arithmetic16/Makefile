export SUT_OBJ_FILE=$(PLATFORM_DIR)/Arithmetic16.a
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(PLATFORM_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(ASSERT_NO_ISR_OBJ_FILE)

all:
	$(MAKE) -C Multiply all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Multiply clean

include $(MAKEFILE_RULES)
