HEX_FILES=\
	FromBinaryTest.hex

FROMBINARY_OBJ_FILES=\
	FromBinaryTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

FromBinaryTest.hex: $(OBJ_FILES) $(FROMBINARY_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(FROMBINARY_OBJ_FILES)

include $(MAKEFILE_RULES)
