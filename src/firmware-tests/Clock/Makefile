export SUT_OBJ_FILE=$(FIRMWARE_DIR)/Clock.o
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(FIRMWARE_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES)

all:
	$(MAKE) -C Initialisation all
	$(MAKE) -C TimeKeeping all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Initialisation clean
	$(MAKE) -C TimeKeeping clean

include $(MAKEFILE_RULES)
