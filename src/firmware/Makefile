HEX_FILENAME=Cluck2Sesame.hex
OBJ_FILES=\
	Cluck2Sesame.o \
	ConfigWords.o \
	Main.o \
	BrownOutReset.o \
	PowerOnReset.o \
	Isr.o

all: $(HEX_FILENAME)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

$(HEX_FILENAME): $(OBJ_FILES)
	$(LD) $(LDARGS) -o $(HEX_FILENAME) $(OBJ_FILES)

include $(MAKEFILE_RULES)
