HEX_FILES=\
#	PinsAreDigitalTest.hex

PINS_ARE_DIGITAL_OBJ_FILES=\
	Timer1SourceIsExternalCrystalTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

PinsAreDigitalTest.hex: $(OBJ_FILES) $(PINS_ARE_DIGITAL_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(PINS_ARE_DIGITAL_OBJ_FILES)

include $(MAKEFILE_RULES)
