HEX_FILES=\
	PollAfterPowerOnResetTest.hex \
	PollAfterBrownOutResetTest.hex \
	PollAfterMclrResetTest.hex \
	PollCalledRepeatedlyTest.hex

POLL_AFTER_POR_OBJ_FILES=\
	PollAfterPowerOnResetTest.o \
	../ResetMocks.o \
	../PollMockToAssertTest.o

POLL_AFTER_BOR_OBJ_FILES=\
	PollAfterBrownOutResetTest.o \
	../ResetMocks.o \
	../PollMockToAssertTest.o

POLL_AFTER_MCLR_OBJ_FILES=\
	PollAfterMclrResetTest.o \
	../ResetMocks.o \
	../PollMockToAssertTest.o

POLL_CALLED_REPEATEDLY_OBJ_FILES=\
	PollCalledRepeatedlyTest.o \
	../ResetDummies.o

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

include $(MAKEFILE_RULES)
