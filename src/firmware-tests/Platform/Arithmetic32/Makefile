export SUT_OBJ_FILE=$(PLATFORM_DIR)/Arithmetic32.a
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(PLATFORM_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(ASSERT_NO_ISR_OBJ_FILE)

all:
	$(MAKE) -C Add all
	$(MAKE) -C Negate all
	$(MAKE) -C SignExtend all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Add clean
	$(MAKE) -C Negate clean
	$(MAKE) -C SignExtend clean

include $(MAKEFILE_RULES)
