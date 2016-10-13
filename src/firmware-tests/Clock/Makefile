export SUT_OBJ_FILE=$(FIRMWARE_DIR)/Clock.o
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(FIRMWARE_CORE_OBJ_FILES) \
	$(FIRMWARE_DIR)/ArithmeticBcd.o \
	$(TEST_FIXTURE_OBJ_FILES)

all:
	$(MAKE) -C Initialisation all
	$(MAKE) -C TimeKeeping all
	$(MAKE) -C Update all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Initialisation clean
	$(MAKE) -C TimeKeeping clean
	$(MAKE) -C Update clean

include $(MAKEFILE_RULES)
