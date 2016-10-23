HEX_FILES=\
	PowerOnResetTest.hex \
	BrownOutResetTest.hex \
	MclrResetTest.hex

POWER_ON_RESET_OBJ_FILES=\
	PowerOnResetTest.o \
	$(ASSERT_NO_ISR_OBJ_FILE) \
	../ResetMocks.o \
	../PollStubToAssertTest.o

BROWN_OUT_RESET_OBJ_FILES=\
	BrownOutResetTest.o \
	$(ASSERT_NO_ISR_OBJ_FILE) \
	../ResetMocks.o \
	../PollStubToAssertTest.o

MCLR_RESET_OBJ_FILES=\
	MclrResetTest.o \
	$(ASSERT_NO_ISR_OBJ_FILE) \
	../ResetMocks.o \
	../PollStubToAssertTest.o

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
