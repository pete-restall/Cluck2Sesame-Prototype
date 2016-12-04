HEX_FILES=\
	PowerOnResetTest.hex \
	BrownOutResetTest.hex \
	MclrResetTest.hex

TEST_DOUBLE_OBJ_FILES=\
	$(ASSERT_NO_ISR_OBJ_FILE) \
	../ResetMocks.o \
	../PollStubToAssertTest.o \
	../../PowerManagement/PowerManagementDummies.o

POWER_ON_RESET_OBJ_FILES=\
	PowerOnResetTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

BROWN_OUT_RESET_OBJ_FILES=\
	BrownOutResetTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

MCLR_RESET_OBJ_FILES=\
	MclrResetTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

PowerOnResetTest.hex: $(OBJ_FILES) $(POWER_ON_RESET_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(POWER_ON_RESET_OBJ_FILES)

BrownOutResetTest.hex: $(OBJ_FILES) $(BROWN_OUT_RESET_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(BROWN_OUT_RESET_OBJ_FILES)

MclrResetTest.hex: $(OBJ_FILES) $(MCLR_RESET_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(MCLR_RESET_OBJ_FILES)

include $(MAKEFILE_RULES)
