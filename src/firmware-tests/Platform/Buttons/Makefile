export SUT_OBJ_FILE=$(PLATFORM_DIR)/Buttons.a
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(FIRMWARE_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(ASSERT_NO_ISR_OBJ_FILE) \
	$(PLATFORM_DIR)/Timer0.a \
	$(PLATFORM_TESTS_DIR)/Timer0/InitialiseAfterTimer0Dummy.o \
	$(PLATFORM_TESTS_DIR)/Timer0/PollAfterTimer0Dummy.o

TEST_DOUBLE_OBJ_FILES=\
	InitialiseAfterButtonsMock.o \
	InitialiseAfterButtonsDummy.o \
	PollAfterButtonsMock.o \
	PollAfterButtonsDummy.o \
	ButtonsDummies.o

all: $(TEST_DOUBLE_OBJ_FILES)
	$(MAKE) -C Initialisation all
	$(MAKE) -C Poll all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Initialisation clean
	$(MAKE) -C Poll clean

include $(MAKEFILE_RULES)
