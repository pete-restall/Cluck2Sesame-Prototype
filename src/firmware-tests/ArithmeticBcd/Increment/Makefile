HEX_FILES=\
	IncrementTest.hex

INCREMENT_OBJ_FILES=\
	IncrementTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

IncrementTest.hex: $(OBJ_FILES) $(INCREMENT_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(INCREMENT_OBJ_FILES)

include $(MAKEFILE_RULES)
