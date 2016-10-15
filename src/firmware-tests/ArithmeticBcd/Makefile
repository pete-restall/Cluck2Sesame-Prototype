export SUT_OBJ_FILE=$(FIRMWARE_DIR)/ArithmeticBcd.a
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(FIRMWARE_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(ASSERT_NO_ISR_OBJ_FILE) \
	$(FIRMWARE_DIR)/Arithmetic4.o

all:
	$(MAKE) -C Add all
	$(MAKE) -C ToBinary all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Add clean
	$(MAKE) -C ToBinary clean

include $(MAKEFILE_RULES)
