export SUT_OBJ_FILE=$(FIRMWARE_DIR)/ShiftRegister.a
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(FIRMWARE_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(ASSERT_NO_ISR_OBJ_FILE) \
	$(CURDIR)/InitialiseAfterShiftRegisterMock.o

all: InitialiseAfterShiftRegisterMock.o
	$(MAKE) -C Initialisation all
	$(MAKE) -C Enable all
	$(MAKE) -C Disable all
	$(MAKE) -C ShiftOut all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Initialisation clean
	$(MAKE) -C Enable clean
	$(MAKE) -C Disable clean
	$(MAKE) -C ShiftOut clean

include $(MAKEFILE_RULES)
