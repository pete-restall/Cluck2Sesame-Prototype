LIB_FILENAME=../ArithmeticBcd.a
OBJ_FILES=\
	Add.o \
	ToBinary.o \
	FromBinary.o

all: $(LIB_FILENAME)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

$(LIB_FILENAME): $(OBJ_FILES)
	$(AR) $(ARARGS) $(LIB_FILENAME) $(OBJ_FILES)

include $(MAKEFILE_RULES)
