HEX_FILES=\
	AddTest.hex

ADD_OBJ_FILES=\
	AddTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

AddTest.hex: $(OBJ_FILES) $(ADD_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ADD_OBJ_FILES)

include $(MAKEFILE_RULES)
