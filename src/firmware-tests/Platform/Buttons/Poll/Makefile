HEX_FILES=\
	PollChainTest.hex \
	ButtonPressTest.hex

POLL_CHAIN_OBJ_FILES=\
	PollChainTest.o \
	../InitialiseAfterButtonsDummy.o \
	../PollAfterButtonsMock.o

BUTTON_PRESS_OBJ_FILES=\
	ButtonPressTest.o \
	../InitialiseAfterButtonsDummy.o \
	../PollAfterButtonsDummy.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

PollChainTest.hex: $(OBJ_FILES) $(POLL_CHAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(POLL_CHAIN_OBJ_FILES)

ButtonPressTest.hex: $(OBJ_FILES) $(BUTTON_PRESS_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(BUTTON_PRESS_OBJ_FILES)

include $(MAKEFILE_RULES)
