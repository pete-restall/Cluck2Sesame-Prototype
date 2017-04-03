export SUT_OBJ_FILE=$(FIRMWARE_DIR)/Ui.a
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(FIRMWARE_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(ASSERT_NO_ISR_OBJ_FILE) \
	$(PLATFORM_DIR)/Flash.o

TEST_DOUBLE_OBJ_FILES=\
	InitialiseAfterUiMock.o \
	InitialiseAfterUiDummy.o \
	PollAfterUiMock.o \
	PollAfterUiDummy.o

all: $(TEST_DOUBLE_OBJ_FILES)
	$(MAKE) -C Initialisation all
	$(MAKE) -C Poll all
	$(MAKE) -C States all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Initialisation clean
	$(MAKE) -C Poll clean
	$(MAKE) -C States clean

include $(MAKEFILE_RULES)
