ASARGS+=-I $(FIRMWARE_DIR)/Lcd

HEX_FILES=\
	InitialisationChainTest.hex \
	InitialStateTest.hex \
	PortaTest.hex \
	AnselTest.hex \
	LcdFlagsAreAllClearedTest.hex \
	LcdContrastIsDefaultedTest.hex

OBJ_FILES+=\
	$(ASSERT_NO_ISR_OBJ_FILE) \
	../PollAfterLcdDummy.o \
	../AdcDummies.o

INITIALISATION_CHAIN_OBJ_FILES=\
	InitialisationChainTest.o \
	../InitialiseAfterLcdMock.o \
	../InitialiseShiftRegisterMock.o \
	../EnableDisableShiftRegisterMocks.o \
	../ShiftOutMock.o

INITIAL_STATE_OBJ_FILES=\
	InitialStateTest.o \
	../InitialiseAfterLcdDummy.o \
	../ShiftRegisterDummies.o

PORTA_OBJ_FILES=\
	PortaTest.o \
	../InitialiseAfterLcdDummy.o \
	../ShiftRegisterDummies.o

ANSEL_OBJ_FILES=\
	AnselTest.o \
	../InitialiseAfterLcdDummy.o \
	../ShiftRegisterDummies.o

LCD_FLAGS_ARE_ALL_CLEARED_OBJ_FILES=\
	LcdFlagsAreAllClearedTest.o \
	../InitialiseAfterLcdDummy.o \
	../ShiftRegisterDummies.o

LCD_CONTRAST_IS_DEFAULTED_OBJ_FILES=\
	LcdContrastIsDefaultedTest.o \
	../InitialiseAfterLcdDummy.o \
	../ShiftRegisterDummies.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

InitialisationChainTest.hex: $(OBJ_FILES) $(INITIALISATION_CHAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(INITIALISATION_CHAIN_OBJ_FILES)

InitialStateTest.hex: $(OBJ_FILES) $(INITIAL_STATE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(INITIAL_STATE_OBJ_FILES)

PortaTest.hex: $(OBJ_FILES) $(PORTA_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(PORTA_OBJ_FILES)

AnselTest.hex: $(OBJ_FILES) $(ANSEL_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ANSEL_OBJ_FILES)

LcdFlagsAreAllClearedTest.hex: $(OBJ_FILES) $(LCD_FLAGS_ARE_ALL_CLEARED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(LCD_FLAGS_ARE_ALL_CLEARED_OBJ_FILES)

LcdContrastIsDefaultedTest.hex: $(OBJ_FILES) $(LCD_CONTRAST_IS_DEFAULTED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(LCD_CONTRAST_IS_DEFAULTED_OBJ_FILES)

include $(MAKEFILE_RULES)
