HEX_FILES=\
	PowerOnResetTest.hex \
	BrownOutResetTest.hex \
	MclrResetTest.hex

SUT_OBJ_FILE=$(FIRMWARE_DIR)/Main.o
OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(FIRMWARE_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(ASSERT_NO_ISR_OBJ_FILE) \
	InitialisationSpies.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

PowerOnResetTest.hex: $(OBJ_FILES) PowerOnResetTest.o
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) PowerOnResetTest.o

BrownOutResetTest.hex: $(OBJ_FILES) BrownOutResetTest.o
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) BrownOutResetTest.o

MclrResetTest.hex: $(OBJ_FILES) MclrResetTest.o
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) MclrResetTest.o

include $(MAKEFILE_RULES)
