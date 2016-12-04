HEX_FILES=\
	PollAfterPowerOnResetTest.hex \
	PollAfterBrownOutResetTest.hex \
	PollAfterMclrResetTest.hex \
	PollCalledRepeatedlyTest.hex \
	FirstPollInChainTest.hex

TEST_DOUBLE_OBJ_FILES=\
	$(ASSERT_NO_ISR_OBJ_FILE) \
	PollAfterFirstInChainDummy.o \
	../../PowerManagement/PowerManagementDummies.o

POLL_AFTER_POR_OBJ_FILES=\
	PollAfterPowerOnResetTest.o \
	$(TEST_DOUBLE_OBJ_FILES) \
	../ResetMocks.o \
	../PollMockToAssertTest.o

POLL_AFTER_BOR_OBJ_FILES=\
	PollAfterBrownOutResetTest.o \
	$(TEST_DOUBLE_OBJ_FILES) \
	../ResetMocks.o \
	../PollMockToAssertTest.o

POLL_AFTER_MCLR_OBJ_FILES=\
	PollAfterMclrResetTest.o \
	$(TEST_DOUBLE_OBJ_FILES) \
	../ResetMocks.o \
	../PollMockToAssertTest.o

POLL_CALLED_REPEATEDLY_OBJ_FILES=\
	PollCalledRepeatedlyTest.o \
	$(TEST_DOUBLE_OBJ_FILES) \
	../ResetDummies.o

FIRST_POLL_IN_CHAIN_OBJ_FILES=\
	FirstPollInChainTest.o \
	$(TEST_DOUBLE_OBJ_FILES) \
	../ResetDummies.o \
	$(PLATFORM_DIR)/Smps.a

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

PollAfterPowerOnResetTest.hex: $(OBJ_FILES) $(POLL_AFTER_POR_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(POLL_AFTER_POR_OBJ_FILES)

PollAfterBrownOutResetTest.hex: $(OBJ_FILES) $(POLL_AFTER_BOR_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(POLL_AFTER_BOR_OBJ_FILES)

PollAfterMclrResetTest.hex: $(OBJ_FILES) $(POLL_AFTER_MCLR_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(POLL_AFTER_MCLR_OBJ_FILES)

PollCalledRepeatedlyTest.hex: $(OBJ_FILES) $(POLL_CALLED_REPEATEDLY_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(POLL_CALLED_REPEATEDLY_OBJ_FILES)

FirstPollInChainTest.hex: $(OBJ_FILES) $(FIRST_POLL_IN_CHAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(FIRST_POLL_IN_CHAIN_OBJ_FILES)

include $(MAKEFILE_RULES)
