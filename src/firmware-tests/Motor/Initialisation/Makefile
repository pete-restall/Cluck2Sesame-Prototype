HEX_FILES=\
	AnselTest.hex \
	PortcTest.hex \
	InitialisationChainTest.hex

ANSEL_OBJ_FILES=\
	AnselTest.o \
	../EnableDisableSmpsMocks.o

PORTC_OBJ_FILES=\
	PortcTest.o \
	../EnableDisableSmpsMocks.o

INITIALISATION_CHAIN_OBJ_FILES=\
	InitialisationChainTest.o \
	../EnableDisableSmpsMocks.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

AnselTest.hex: $(OBJ_FILES) $(ANSEL_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ANSEL_OBJ_FILES)

PortcTest.hex: $(OBJ_FILES) $(PORTC_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(PORTC_OBJ_FILES)

InitialisationChainTest.hex: $(OBJ_FILES) $(INITIALISATION_CHAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(INITIALISATION_CHAIN_OBJ_FILES)

include $(MAKEFILE_RULES)
