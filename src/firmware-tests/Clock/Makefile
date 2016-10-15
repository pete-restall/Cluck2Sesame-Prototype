export SUT_OBJ_FILE=$(FIRMWARE_DIR)/Clock.a
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(FIRMWARE_CORE_OBJ_FILES) \
	$(FIRMWARE_DIR)/Arithmetic4.o \
	$(FIRMWARE_DIR)/ArithmeticBcd.a \
	$(TEST_FIXTURE_OBJ_FILES)

all:
	$(MAKE) -C Initialisation all
	$(MAKE) -C TimerWiring all
	$(MAKE) -C Poll all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Initialisation clean
	$(MAKE) -C TimerWiring clean
	$(MAKE) -C Poll clean

include $(MAKEFILE_RULES)
