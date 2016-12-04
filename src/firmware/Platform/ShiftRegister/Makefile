LIB_FILENAME=../ShiftRegister.a
OBJ_FILES=\
	Initialise.o \
	EnableDisable.o \
	ShiftOut.o

all: $(LIB_FILENAME)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

$(LIB_FILENAME): $(OBJ_FILES)
	$(AR) $(ARARGS) $(LIB_FILENAME) $(OBJ_FILES)

include $(MAKEFILE_RULES)
