LIB_FILENAME=../Arithmetic32.a
OBJ_FILES=\
	Add.o \
	Negate.o \
	SignExtend.o

all: $(LIB_FILENAME)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

$(LIB_FILENAME): $(OBJ_FILES)
	$(AR) $(ARARGS) $(LIB_FILENAME) $(OBJ_FILES)

include $(MAKEFILE_RULES)
