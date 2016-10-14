OBJ_FILES=\
	$(FIRMWARE_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(ASSERT_NO_ISR_OBJ_FILE) \
	$(FIRMWARE_DIR)/Clock.a \
	$(FIRMWARE_DIR)/ArithmeticBcd.o \
	FirstInitialisationInChainTest.o

HEX_FILES=FirstInitialisationInChainTest.hex

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

FirstInitialisationInChainTest.hex: $(OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES)

include $(MAKEFILE_RULES)
