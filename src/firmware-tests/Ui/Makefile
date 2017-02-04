export SUT_OBJ_FILE=$(FIRMWARE_DIR)/Ui.a
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(FIRMWARE_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(ASSERT_NO_ISR_OBJ_FILE) \
	$(CURDIR)/InitialiseAfterUiMock.o

TEST_DOUBLE_OBJ_FILES=\
	InitialiseAfterUiMock.o \
	PollAfterUiMock.o

all: $(TEST_DOUBLE_OBJ_FILES)
	$(MAKE) -C Initialisation all
	$(MAKE) -C Poll all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Initialisation clean
	$(MAKE) -C Poll clean

include $(MAKEFILE_RULES)
