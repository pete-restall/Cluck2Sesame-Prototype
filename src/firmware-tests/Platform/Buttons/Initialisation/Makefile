HEX_FILES=\
	InitialisationChainTest.hex \
	InterruptOnChangeTest.hex \
	AnselTest.hex \
	ButtonFlagsTest.hex

INITIALISATION_CHAIN_OBJ_FILES=\
	InitialisationChainTest.o \
	../InitialiseAfterButtonsMock.o \
	../PollAfterButtonsDummy.o

INTERRUPT_ON_CHANGE_OBJ_FILES=\
	InterruptOnChangeTest.o \
	../InitialiseAfterButtonsDummy.o \
	../PollAfterButtonsDummy.o

ANSEL_OBJ_FILES=\
	AnselTest.o \
	../InitialiseAfterButtonsDummy.o \
	../PollAfterButtonsDummy.o

BUTTON_FLAGS_OBJ_FILES=\
	ButtonFlagsTest.o \
	../InitialiseAfterButtonsDummy.o \
	../PollAfterButtonsDummy.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

InitialisationChainTest.hex: $(OBJ_FILES) $(INITIALISATION_CHAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(INITIALISATION_CHAIN_OBJ_FILES)

InterruptOnChangeTest.hex: $(OBJ_FILES) $(INTERRUPT_ON_CHANGE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(INTERRUPT_ON_CHANGE_OBJ_FILES)

AnselTest.hex: $(OBJ_FILES) $(ANSEL_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ANSEL_OBJ_FILES)

ButtonFlagsTest.hex: $(OBJ_FILES) $(BUTTON_FLAGS_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(BUTTON_FLAGS_OBJ_FILES)

include $(MAKEFILE_RULES)
