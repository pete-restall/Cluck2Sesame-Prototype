HEX_FILES=\
	ToBinaryTest.hex

TOBINARY_OBJ_FILES=\
	ToBinaryTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

ToBinaryTest.hex: $(OBJ_FILES) $(TOBINARY_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(TOBINARY_OBJ_FILES)

include $(MAKEFILE_RULES)
