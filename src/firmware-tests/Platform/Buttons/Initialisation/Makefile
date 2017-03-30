HEX_FILES=\
	InitialisationChainTest.hex \
	InterruptOnChangeTest.hex \
	ButtonStatesTest.hex

INITIALISATION_CHAIN_OBJ_FILES=\
	InitialisationChainTest.o \
	../PollAfterButtonsMock.o

INTERRUPT_ON_CHANGE_OBJ_FILES=\
	InterruptOnChangeTest.o \
	../PollAfterButtonsDummy.o

BUTTON_STATES_OBJ_FILES=\
	ButtonStatesTest.o \
	../PollAfterButtonsDummy.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

InitialisationChainTest.hex: $(OBJ_FILES) $(INITIALISATION_CHAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(INITIALISATION_CHAIN_OBJ_FILES)

InterruptOnChangeTest.hex: $(OBJ_FILES) $(INTERRUPT_ON_CHANGE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(INTERRUPT_ON_CHANGE_OBJ_FILES)

ButtonStatesTest.hex: $(OBJ_FILES) $(BUTTON_STATES_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(BUTTON_STATES_OBJ_FILES)

include $(MAKEFILE_RULES)
