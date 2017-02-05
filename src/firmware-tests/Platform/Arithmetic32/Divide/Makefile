HEX_FILES=\
	DivideTest.hex

DIVIDE_OBJ_FILES=\
	DivideTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

DivideTest.hex: $(OBJ_FILES) $(DIVIDE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(DIVIDE_OBJ_FILES)

include $(MAKEFILE_RULES)
